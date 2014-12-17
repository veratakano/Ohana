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
				        		'title': 'Father',
				        		'text': '',
				        		'top': 200,
				        		'left': 20,
				      		},
				      		{
				        		'id': 1,
				        		'title': 'Mother',
				        		'text': '',
				        		'top': 20,
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
				        		'text': '',
				        		'top': 200,
				        		'left': 20,
				      		},
				      		{
				        		'id': 3,
				        		'title': 'Daughter',
				        		'text': '',
				        		'top': 20,
				        		'left': 500,
				      		},
				      		{
				        		'id': 4,
				        		'title': 'Son',
				        		'text': '',
				        		'top': 20,
				        		'left': 500,
				      		},
				      	]
				      	}
				    ],
				    'connections': [
				      {'from': 'node1', 'to': 'node0', 'pos1':'Left', 'pos2':'Right'},
				      {'from': 'node2', 'to': 'node0', 'pos1':'TopCenter', 'pos2':'Bottom'},
				      {'from': 'node3', 'to': 'node0', 'pos1':'TopCenter', 'pos2':'Bottom'},
				      {'from': 'node4', 'to': 'node0', 'pos1':'TopCenter', 'pos2':'Bottom'},
				    ],
				 });
				return flowchart;
		}
	};
}])