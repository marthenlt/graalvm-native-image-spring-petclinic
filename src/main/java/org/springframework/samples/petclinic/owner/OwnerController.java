/*
 * Copyright 2012-2019 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.springframework.samples.petclinic.owner;

import org.springframework.samples.petclinic.visit.VisitRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.time.LocalDate;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Random;

/**
 * @author Juergen Hoeller
 * @author Ken Krebs
 * @author Arjen Poutsma
 * @author Michael Isvy
 */
@Controller
class OwnerController {

	private static final String VIEWS_OWNER_CREATE_OR_UPDATE_FORM = "owners/createOrUpdateOwnerForm";

	private final OwnerRepository owners;

	private VisitRepository visits;

	private PetRepository petRepository;

	public OwnerController(OwnerRepository clinicService, VisitRepository visits, PetRepository petRepository) {
		this.owners = clinicService;
		this.visits = visits;
		this.petRepository = petRepository;
	}

	@InitBinder
	public void setAllowedFields(WebDataBinder dataBinder) {
		dataBinder.setDisallowedFields("id");
	}

	@GetMapping("/owners/new")
	public String initCreationForm(Map<String, Object> model) {
		Owner owner = new Owner();
		model.put("owner", owner);
		return VIEWS_OWNER_CREATE_OR_UPDATE_FORM;
	}

	@PostMapping("/owners/new")
	public String processCreationForm(@Valid Owner owner, BindingResult result) {
		if (result.hasErrors()) {
			return VIEWS_OWNER_CREATE_OR_UPDATE_FORM;
		}
		else {
			this.owners.save(owner);
			return "redirect:/owners/" + owner.getId();
		}
	}

	@GetMapping("/owners/find")
	public String initFindForm(Map<String, Object> model) {
		model.put("owner", new Owner());
		return "owners/findOwners";
	}

	@GetMapping("/owners")
	public String processFindForm(Owner owner, BindingResult result, Map<String, Object> model) {

		// allow parameterless GET request for /owners to return all records
		if (owner.getLastName() == null) {
			owner.setLastName(""); // empty string signifies broadest possible search
		}

		// find owners by last name
		Collection<Owner> results = this.owners.findByLastName(owner.getLastName());
		if (results.isEmpty()) {
			// no owners found
			result.rejectValue("lastName", "notFound", "not found");
			return "owners/findOwners";
		}
		else if (results.size() == 1) {
			// 1 owner found
			owner = results.iterator().next();
			return "redirect:/owners/" + owner.getId();
		}
		else {
			// multiple owners found
			model.put("selections", results);
			return "owners/ownersList";
		}
	}

	@GetMapping("/owners/{ownerId}/edit")
	public String initUpdateOwnerForm(@PathVariable("ownerId") int ownerId, Model model) {
		Owner owner = this.owners.findById(ownerId);
		model.addAttribute(owner);
		return VIEWS_OWNER_CREATE_OR_UPDATE_FORM;
	}

	@GetMapping("/owners/all")
	public String getOwnersAll(Map<String, Object> model) {
		Collection<Owner> results = this.owners.findAllOwners();
		System.out.println("results from /owners/all call : " + results.size());
		model.put("selections", results);
		return "owners/ownersListWithoutPets";
	}

	@GetMapping("/doscale")
	public String scaleItUp(Map<String, Object> model) {
		String localhost = "(VERSION: " + System.getenv("VERSION") + ")  ;  served from: ";
		try {
			localhost += InetAddress.getLocalHost().getHostName();
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}
		System.out.println(localhost);
		model.put("servedby", localhost);
		return "faas/empty";
	}

	@GetMapping("/populate")
	public String populate(Map<String, Object> model) {
		String info = "Successfully populating 1K owners and 1K pets data..";
		for (int i=0; i < 1_000; i++) {
			Owner owner = new Owner();
			owner.setFirstName("firstname-" + i);
			owner.setLastName("lastname-" + i);
			owner.setAddress("address-" +i);
			owner.setCity("city-" +i);
			owner.setTelephone(String.valueOf(i));
			owners.save(owner);

			List<PetType> petTypes = petRepository.findPetTypes();
			Random random = new Random();
			PetType petType = petTypes.get(random.nextInt(petTypes.size()-1));

			Pet pet = new Pet();
			pet.setName("pet-" + i);
			pet.setBirthDate(LocalDate.of(2020, 1, 8));
			pet.setOwner(owner);
			pet.setType(petType);
			petRepository.save(pet);
		}
		model.put("info", info);
		System.out.println(info);
		return "faas/info";
	}

	@PostMapping("/owners/{ownerId}/edit")
	public String processUpdateOwnerForm(@Valid Owner owner, BindingResult result,
			@PathVariable("ownerId") int ownerId) {
		if (result.hasErrors()) {
			return VIEWS_OWNER_CREATE_OR_UPDATE_FORM;
		}
		else {
			owner.setId(ownerId);
			this.owners.save(owner);
			return "redirect:/owners/{ownerId}";
		}
	}

	/**
	 * Custom handler for displaying an owner.
	 * @param ownerId the ID of the owner to display
	 * @return a ModelMap with the model attributes for the view
	 */
	@GetMapping("/owners/{ownerId}")
	public ModelAndView showOwner(@PathVariable("ownerId") int ownerId) {
		ModelAndView mav = new ModelAndView("owners/ownerDetails");
		Owner owner = this.owners.findById(ownerId);
		for (Pet pet : owner.getPets()) {
			pet.setVisitsInternal(visits.findByPetId(pet.getId()));
		}
		mav.addObject(owner);
		return mav;
	}

}
