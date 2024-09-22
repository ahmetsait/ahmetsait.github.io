const mediaQuery = window.matchMedia("(prefers-color-scheme: dark)");

function getTheme() {
	const dark = localStorage.getItem("dark-theme");
	return dark === null ? null : dark !== "0";
}

function isDark(dark : boolean | null) {
	return dark ?? mediaQuery.matches;
}

function setTheme(dark : boolean | null) {
	if (dark === null)
		localStorage.removeItem("dark-theme");
	else
		localStorage.setItem("dark-theme", dark ? "1" : "0");
	applyTheme(isDark(dark));
}

function theme() {
	return isDark(getTheme());
}

function applyTheme(dark : boolean) {
	for (const sheet of document.getElementsByClassName("stylesheet-dark")) {
		if (sheet instanceof HTMLLinkElement)
			sheet.disabled = !dark;
	}
}

function refreshTheme() {
	applyTheme(theme());
}

mediaQuery.addEventListener("change", (event) => refreshTheme());

refreshTheme();
