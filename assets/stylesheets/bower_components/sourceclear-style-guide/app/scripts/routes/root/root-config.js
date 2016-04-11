angular.module('SC.routes.root', [])
	.config(function($stateProvider) {
    	'use strict';



		// 
		// Define a state, just so people feel better with a /login url, 
		// we don't really need it
		// 
	    $stateProvider
			.state('root', {
				url: '/',
				controller: 'RootCtrl',
				templateUrl: '/scripts/routes/root/root-view.html',
				data: {
					pageClass: 'page--root',
					pageTitle: 'Style Guide - SourceClear'
				}
			});



	});