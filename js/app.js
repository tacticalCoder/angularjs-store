(function () {
	var app = angular.module('store', ['store-directives']);
	var restApiUrl = 'rest/index.cfm?endpoint=/';

	app.controller('StoreController', ['$http', function($http) {
		var store = this;
		store.products = [];
		$http.get(restApiUrl + 'products').success(function(data) {
			store.products = data;
		});
	}]);

	app.controller('ReviewController', ['$scope', '$http', function($scope, $http) {
		this.review = {};
		this.addReview = function (product) {
			this.review['productId'] = product.id;
			$http.post(restApiUrl + 'reviews/0', this.review)
				.success(function(data){
					product.reviews.push(this.review);
					this.review = {};
				})
				.error(function(data){
					$scope.errors = data;
				});
		};
	}]);
})();
