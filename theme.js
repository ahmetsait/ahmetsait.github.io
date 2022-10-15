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
	if (dark === null)
		document.getElementById("style-dark").disabled = !mq.matches;
	else
		document.getElementById("style-dark").disabled = !(dark === "1");
}

mediaQuery.addEventListener("change", refreshTheme);

refreshTheme(mediaQuery);
