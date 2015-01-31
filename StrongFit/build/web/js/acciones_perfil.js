$(function() {
	var $link_1 = document.getElementById('link_1');
	var $link_2 = document.getElementById('link_2');
	var $link_3 = document.getElementById('link_3');
	var $formu1 = document.getElementById('formu_1');
	var $formu2 = document.getElementById('formu_2');
	var $formu3 = document.getElementById('formu_3');
	function showMenu_1(e) {
		e.preventDefault();
		console.log("Hola");
		$formu1.classList.add('is-active');
		$formu2.classList.remove('is-active');
		$formu3.classList.remove('is-active');
		$link_1.classList.add('activo');
		$link_2.classList.remove('activo');
		$link_3.classList.remove('activo');
	}
	function showMenu_2(e) {
		e.preventDefault();
		console.log("Hola");
		$formu1.classList.remove('is-active');
		$formu2.classList.add('is-active');
		$formu3.classList.remove('is-active');
		$link_1.classList.remove('activo');
		$link_2.classList.add('activo');
		$link_3.classList.remove('activo');
	}
	function showMenu_3(e) {
		e.preventDefault();
		console.log("Hola");
		$formu1.classList.remove('is-active');
		$formu2.classList.remove('is-active');
		$formu3.classList.add('is-active');
		$link_1.classList.remove('activo');
		$link_2.classList.remove('activo');
		$link_3.classList.add('activo');
	}
	$link_1.addEventListener('click', showMenu_1);
	$link_2.addEventListener('click', showMenu_2);
	$link_3.addEventListener('click', showMenu_3);
})