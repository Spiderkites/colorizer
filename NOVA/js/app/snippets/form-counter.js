
const Classes = {
	counter	: 'form-counter'
};

const Data = {
	up		: 'data-count-up',
	down	: 'data-count-down'
};


const proxy = function(fn, ...args) {
	return function() {
		fn.call(this, ...args)
	}
};

const updateCount = function(increase = false) {
	let $input = $(this).parents(`.${Classes.counter}`).find('.form-control');
	let input = $input.get(0);
	let stepDirection = increase ? 'stepUp' : 'stepDown';

	try {
		input[stepDirection]()
		$input.trigger('change')
	} catch(e) {
		let step = input.step > 0 ? parseFloat(input.step) : 1;

		let newValue = increase ? parseFloat(input.value) + step : parseFloat(input.value) - step;

		if(newValue > parseFloat(input.max)) return;
		if(newValue < parseFloat(input.min)) return;

		input.value = (newValue).toFixed($input.data('decimals'));
	}
};

window.initNumberInput = function () {
	$(`[${Data.up}]`).on('click', proxy(updateCount, true));
	$(`[${Data.down}]`).on('click', proxy(updateCount));
	$(`.${Classes.counter} .form-control`).on('blur', function() {
		let min = parseInt(this.min);
		let max = parseInt(this.max);
		let value = parseInt(this.value);

		if(value < min) this.value = min;
		if(value > max) this.value = max;
	})
};
