for (const dropdownButton of document.getElementsByClassName("dropdown-button")) {
	dropdownButton.addEventListener("click", () => {
		dropdownButton.nextElementSibling?.classList.toggle("hidden");
	});
}

document.addEventListener("pointerdown", documentOnPointerDown);

function documentOnPointerDown(event: PointerEvent) {
	const target = event.target as HTMLElement;
	for (const dropdown of document.getElementsByClassName("dropdown")) {
		if (!dropdown.contains(target)) {
			for (const menu of dropdown.getElementsByClassName("dropdown-menu"))
				menu.classList.add("hidden");
		}
	}
}

for (const menu of document.getElementsByClassName("dropdown-menu")) {
	for (const element of menu.children) {
		element.addEventListener("click", closeDropdowns);
	}
}

function closeDropdowns() {
	for (const menu of document.getElementsByClassName("dropdown-menu")) {
		menu.classList.add("hidden");
	}
}

let email = document.getElementById("email") as HTMLAnchorElement;
email.href = atob("bWFpbHRvOmJsb2dAYWhtZXRzYWl0LmNvbQ==");
