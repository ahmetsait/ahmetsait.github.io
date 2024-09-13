for (const dropdownButton of document.getElementsByClassName("dropdown-button")) {
	dropdownButton.addEventListener("click", (event) => {
		dropdownButton.nextElementSibling?.classList.toggle("hidden");
	});
}

document.addEventListener("pointerdown", closeDropdown);

for (const dropdown of document.getElementsByClassName("dropdown-menu")) {
	for (const element of dropdown.children) {
		element.addEventListener("click", () => closeDropdown());
	}
}

function closeDropdown(event) {
	for (const dropdown of document.getElementsByClassName("dropdown-menu")) {
		if (event === undefined || !dropdown.parentNode?.contains(event.target))
			dropdown.classList.add("hidden");
	}
}

let email = document.getElementById("email");
email.href = atob("bWFpbHRvOmJsb2dAYWhtZXRzYWl0LmNvbQ==");
