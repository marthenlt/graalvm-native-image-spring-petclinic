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
import java.math.BigInteger;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.time.LocalDate;
import java.util.*;

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
		String version = System.getenv("VERSION");
		String hostname = "";
		try {
			hostname += InetAddress.getLocalHost().getHostName();
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}
		String color = System.getenv("COLOR");
		System.out.println("==> within /doscale ==> version:" + version + "   ;   served by:" + hostname + "   ;   color:" + color);
		model.put("version", version);
		model.put("color", color);
		model.put("hostname", hostname);
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

	@GetMapping("/cpu-intensive-operation/{loop}")
	public String cpuIntensiveOperation(@PathVariable("loop") long loop, Model model) {
		long startTime = System.currentTimeMillis();
		long loopInThousands = loop * 1_000;
		long count = 0;
		long max = 0;
		for (long i=3; i<=loopInThousands; i++) {
			boolean isPrime = true;
			for (long j=2; j<=i/2 && isPrime; j++) {
				isPrime = i % j > 0;
			}
			if (isPrime) {
				count++;
				max = i;
			}
		}
		long curTime = System.currentTimeMillis();
		long duration = (curTime - startTime)/1000;
		model.addAttribute("info", "Finding max prime number from " + loopInThousands + ", and the result is (max): " + max + "  ;  duration: " + duration);
		return "faas/info";
	}

	@GetMapping("/mem-intensive-operation/{size}")
	public String memIntensiveOperation(@PathVariable("size") int size, Model model) {
		long startTime = System.currentTimeMillis();
		int sizeInThousands = size * 1_000;
		Owner[] owners = null;
		for (int i = 0; i < 1000; i++) {
			owners = new Owner[sizeInThousands];
		}
		long curTime = System.currentTimeMillis();
		long duration = (curTime - startTime)/1000;
		model.addAttribute("info", "Array of owners with size of " + sizeInThousands + " have been created. Duration : " + duration);
		return "faas/info";
	}

	//****************************************
	//Memory leak use case..
	//========================================
	//The problem is global static variable with no/unlimited size
	public static List<Double> memoryLeakList = new ArrayList<>();

	@GetMapping("/mem-leak-operation/{size}")
	public String memLeakOperation(@PathVariable("size") int size, Model model) {
		long startTime = System.currentTimeMillis();
		int sizeInThousands = size * 1_000;
		for (int i = 0; i < size; i++) {
			memoryLeakList.add(Math.random());
		}
		long curTime = System.currentTimeMillis();
		long duration = (curTime - startTime)/1000;
		model.addAttribute("info", "Memory leak test -- Static array of list with size of " + sizeInThousands + " have been created. Duration : " + duration);
		return "faas/info";
	}
	@GetMapping("/mem-non-leak-operation/{size}")
	public String memNonLeakOperation(@PathVariable("size") int size, Model model) {
		//The solution is localized non-static variable..
		List<Double> nonMemoryLeakList = new ArrayList<>();
		long startTime = System.currentTimeMillis();
		int sizeInThousands = size * 1_000;
		for (int i = 0; i < size; i++) {
			nonMemoryLeakList.add(Math.random());
		}
		long curTime = System.currentTimeMillis();
		long duration = (curTime - startTime)/1000;
		model.addAttribute("info", "Memory leak test -- Static array of list with size of " + sizeInThousands + " have been created. Duration : " + duration);
		nonMemoryLeakList = null; //once it is not used, we clean it..
		return "faas/info";
	}

	//****************************************
	//Method profiling use case..
	//========================================
	//The problem is using + operator to concatenate strings
	public String stringAppend(int max) {
		String s = "";
		for (int i = 0; i < max; i++) {
			if (s.length() > 0)
				s += ", ";
			s += "string";
		}
		return s;
	}
	//The solution is to use StringBuilder.append()
	public String stringBuilderAppend(int max) {
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < max; i++) {
			if (sb.length() > 0)
				sb.append(", ");
			sb.append("string");
		}
		return sb.toString();
	}
	@GetMapping("/string-append/{size}")
	public String stringAppendOperation(@PathVariable("size") int size, Model model) {
		long startTime = System.currentTimeMillis();
		int sizeInThousands = size * 1_000;
		String result = "";
		result = stringAppend(sizeInThousands);
		long curTime = System.currentTimeMillis();
		long duration = (curTime - startTime)/1000;
		model.addAttribute("info", "String append with max loop of " + sizeInThousands + " have been created. Duration : " + duration);
		return "faas/info";
	}
	@GetMapping("/stringbuilder-append/{size}")
	public String stringBuilderAppendOperation(@PathVariable("size") int size, Model model) {
		long startTime = System.currentTimeMillis();
		int sizeInThousands = size * 1_000;
		String result = "";
		result = stringBuilderAppend(sizeInThousands);
		long curTime = System.currentTimeMillis();
		long duration = (curTime - startTime)/1000;
		model.addAttribute("info", "StringBuilder append with max loop of " + sizeInThousands + " have been created. Duration : " + duration);
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
