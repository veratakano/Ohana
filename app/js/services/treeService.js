'use strict';

app.factory('treeService', ['$http','$location', '$rootScope', 'sessionService', function($http, $location, $rootScope, sessionService){
	return{
		getTreeData:function(){

				var flowchart = ({
				    'id': 1,
				    'generations': [
				    	{
				    	"gen": "1",
				    	'nodes': [
				      		{
				        		'id': 0,
				        		'title': 'Dad',
				        		'gender': 'M',
				        		'text': '',
								'father': 'abc',
				        		'top': 100,
				        		'left': 20,
				      		},
				      		{
				        		'id': 1,
				        		'title': 'Mother',
				        		'gender': 'f',
				        		'text': '',
								'father': 'abc',
				        		'top': 300,
				        		'left': 500,
				      		},
				      	]
				     	},
				     	{
				     	"gen": "2",		
				      	'nodes': [
				      		{
				        		'id': 2,
				        		'title': 'Son',
				        		'gender': 'm',
				        		'text': '',
								'father': 'abc',
				        		'top': 200,
				        		'left': 20,
				      		},
				      		{
				        		'id': 3,
				        		'title': 'Daughter',
				        		'gender': 'f',
				        		'text': '',
								'father': 'abc',
				        		'top': 20,
				        		'left': 500,
				      		},
				      		{
				        		'id': 4,
				        		'title': 'Son',
				        		'gender': 'm',
				        		'text': '',
								'father': 'abc',
				        		'top': 20,
				        		'left': 500,
				      		},
				      	]
				      	},
						{
				     	"gen": "3",		
				      	'nodes': [
				      		{
				        		'id': 2,
				        		'title': 'GrandSon',
				        		'gender': 'm',
				        		'text': '',
								'father': 'abc',
				        		'top': 200,
				        		'left': 20,
				      		},
				      		{
				        		'id': 3,
				        		'title': 'Grand Daughter',
				        		'gender': 'f',
				        		'text': '',
								'father': 'abc',
				        		'top': 20,
				        		'left': 500,
				      		},
				      		{
				        		'id': 4,
				        		'title': 'Son Son',
				        		'gender': 'm',
				        		'text': '',
								'father': 'abc',
				        		'top': 20,
				        		'left': 500,
				      		},
				      	]
				      	}
				    ],
				    'connections': [
				      {'from': 'node1', 'to': 'node0', 'pos1':'Left', 'pos2':'Right'},
				      {'from': 'node2', 'to': 'node0', 'pos1':'TopCenter', 'pos2':'Bottom'},
				      {'from': 'node3', 'to': 'node1', 'pos1':'TopCenter', 'pos2':'Bottom'},
				      {'from': 'node4', 'to': 'node0', 'pos1':'TopCenter', 'pos2':'Bottom'},
				    ],
				 });
				return flowchart;
		}
	};
}])