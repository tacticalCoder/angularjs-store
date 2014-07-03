(function () {
	var app = angular.module('store', ['store-directives']);
	var restApiUrl = 'rest/index.cfm?endpoint=/';

	app.controller('StoreController', ['$http', function($http) {
		var storeCtrl = this;
		storeCtrl.products = [];
		$http.get(restApiUrl + 'products').success(function(data) {
			storeCtrl.products = data;
		});
	}]);

	app.controller('ReviewController', ['$http', function($http) {
		var reviewCtrl = this;

		reviewCtrl.review = {};
		reviewCtrl.errors = {};

		reviewCtrl.addReview = function (product) {
			reviewCtrl.review['productId'] = product.id;

			$http.post(restApiUrl + 'reviews/0', reviewCtrl.review)
				.success(function(data){
					product.reviews.push(reviewCtrl.review);

					reviewCtrl.review = {};
					reviewCtrl.errors = {};
				})
				.error(function(data){
					reviewCtrl.errors = data;
				});
		};
	}]);
})();
