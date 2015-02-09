$(function() {
	var $btnNext = $('#next'),
		$btnEnvia = $('#envia'),
		$btnPrev = $('#prev'),
		$formu1 = $('#formu1'),
		$formu2 = $('#formu2'),
		$formu3 = $('#formu3'),
		i = 0;
	function evalua(i){
		if(i==0){
			$formu1.addClass('is-active');
			$formu2.removeClass('is-active');
			$formu3.removeClass('is-active');
			$btnNext.removeClass('cuenta');
			$btnEnvia.addClass('cuenta');
			$btnPrev.addClass('cuenta');
		}
		if(i==1){
			$formu1.removeClass('is-active');
			$formu2.addClass('is-active');
			$formu3.removeClass('is-active');
			$btnNext.removeClass('cuenta');
			$btnEnvia.addClass('cuenta');
			$btnPrev.removeClass('cuenta');
		}
		if(i==2){
			$formu1.removeClass('is-active');
			$formu2.removeClass('is-active');
			$formu3.addClass('is-active');
			$btnNext.addClass('cuenta');
			$btnEnvia.removeClass('cuenta');
			$btnPrev.removeClass('cuenta');
		}
	}
	function next(e){
		e.preventDefault();
		++i
		evalua(i);
	}
	function prev(e){
		e.preventDefault();
		--i;
		evalua(i);
	}
	$btnNext.click(next);
	$btnPrev.click(prev);
})