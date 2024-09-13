const mediaQuery = window.matchMedia("(prefers-color-scheme: dark)");

function setTheme(dark) {
	if (dark === null)
		localStorage.removeItem("dark-theme");
	else
		localStorage.setItem("dark-theme", dark ? "1" : "0");
	refreshTheme(mediaQuery);
}

function refreshTheme(mq) {
	const dark = localStorage.getItem("dark-theme");
	for (const sheet of document.getElementsByClassName("stylesheet-dark")) {
		sheet.disabled = dark === null ? !mq.matches : !(dark === "1");
	}
}

mediaQuery.addEventListener("change", refreshTheme);

refreshTheme(mediaQuery);
