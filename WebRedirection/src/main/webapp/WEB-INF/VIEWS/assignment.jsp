<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" 
           uri="http://java.sun.com/jsp/jstl/core" %>
           <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>    
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script>
<!-- <script src="http://cdnjs.cloudflare.com/ajax/libs/angular.js/1.3.10/angular.min.js"></script> -->
<link href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css" rel="stylesheet">
<style type="text/css">
@import url(http://fonts.googleapis.com/css?family=Lato);
body {
  background-color: #eaeaea;
  color: #333;
  font-family: Lato;
  -webkit-font-smoothing: antialiased;
}
[contenteditable="true"]:focus {
  outline: 1px solid black;
}
h1 {
  margin: 20px;
  text-align: left;
  color: #DA4453;
}
h2 {
  text-align: right;
  line-height: 1;
  margin: 0 0 10px 0;
  padding: 0;
}
h3 {
  line-height: 1.5;
  margin: 0;
  padding: 0;
  color: #ED5565;
}
h4 {
  line-height: 1;
  margin: 0;
  padding: 0;
  text-align: left;
  color: #ED5565;
}
a {
  color: #e8273b;
  transition: all 0.3s ease-in-out;
}
a:hover {
  color: #c71528;
  text-shadow: 0px 0px 12px #ED5565;
}
#page {
  width: 960px;
  margin: 0px auto;
}
#users {
  float: left;
  margin: 0 0 0 20px;
}
#users h3 {
  text-align: right;
}
#completed-tasks {
  float: left;
  width: 23%;
  padding: 0px;
  overflow-x: hidden;
}
#completed-tasks.open {
  width: 23%;
}
#completed-tasks .actions {
  display: none;
}
#completed-tasks .task {
  border-width: 0px 0px 1px 0px;
}
#completed-tasks .task p {
  text-decoration: line-through;
}
.user-panel {
  display: inline-block;
  padding: 8px;
  width: 200px;
  vertical-align: top;
  background-color: #fff;
  border-radius: 3px;
}
.user-name.over ~ .task-list {
  border: 3px dashed #dadada;
}
.toolbar {
  text-align: right;
  line-height: 30px;
  padding: 0px 6px;
  display: none;
}
.task-list {
  position: relative;
  margin: 4px 0px 0px 0px;
}
.task {
  position: relative;
  background-color: #eaeaea;
  text-align: left;
  padding: 0px 0px 0px 4px;
  margin: 0px 0px 1px 0px;
  border: 1px solid #dadada;
  border-width: 1px 1px 0px 1px;
}
.task:last-child {
  border-width: 1px;
}
.task > p {
  color: #808080;
  margin: 0;
  padding: 0;
  line-height: 30px;
  display: inline-block;
  width: 90%;
  vertical-align: top;
}
.actions {
  position: absolute;
  display: inline-block;
  padding: 0px;
  margin: 0px -200px 0 0;
  width: 19px;
  height: 22px;
  z-index: 10;
  overflow: hidden;
  background-color: #fff;
  opacity: 0.5;
  transition: all 0.75s ease-in-out;
}
.actions:hover {
  width: 150px;
  opacity: 1;
}
.actions a {
  padding: 0px 10px;
}
.task.over {
  border-top: 3px dashed #dadada;
}

</style>
<script type="text/javascript">
;(function ( $, window, undefined ) {
	  var pluginName = 'dragDrop',
		  document = window.document,
		  defaults = {
			  draggableSelector: ".draggable",
			  droppableSelector: ".droppable",
	      	  appendToSelector: false
		  };


	  function Plugin( element, options ) {
		  this.element = element;
		  this.options = $.extend( {}, defaults, options) ;

		  this._defaults = defaults;
		  this._name = pluginName;

		  this.init();
	  }

	  Plugin.prototype.init = function () {
		  var droppables = $(this.element).find(this.options.droppableSelector);
		  var draggables = $(this.element).find(this.options.draggableSelector).attr("draggable", "true");
	    
	    if(this.options.appendToSelector){
	      var appendables = $(this.options.appendToSelector);
	      
	      appendables.on({
	        'dragenter': function(ev){
	          ev.preventDefault();
	          return true;
	        },
	        'drop': function(ev){
	          var data = ev.originalEvent.dataTransfer.getData("Text");
	          var draggedEl = document.getElementById(data);
	          var destinationEl = $(ev.target);

	          destinationEl = destinationEl.closest(appendables.selector).siblings(droppables.selector).append(draggedEl);
	          $('.active').removeClass('active');
	          $('.over').removeClass('over');
	          ev.stopPropagation();
	          return false;
	        },
	        'dragover': function(ev){
	          ev.preventDefault();
	          $(ev.target).closest(appendables.selector).addClass('over');
	          return true;
	        },
	        'dragleave': function(ev){
	          ev.preventDefault();
	          $(ev.target).closest(appendables.selector).removeClass('over');
	          return true;
	        }
	      });
	    }
	    
	    droppables.on({
	      'mouseup': function(ev){
	        $('.active').removeClass('active');
	        return true;
	      },
	      'dragenter': function(ev){
	        ev.preventDefault();
	        return true;
	      },
	      'drop': function(ev){
	        var data = ev.originalEvent.dataTransfer.getData("Text");
	        var draggedEl = document.getElementById(data);
	        var destinationEl = $(ev.target);
	        
	        destinationEl.closest(draggables.selector).before(draggedEl);
	        $('.active').removeClass('active');
	        $('.over').removeClass('over');
	        ev.stopPropagation();
	        return false;
	      },
	      'dragover': function(ev){
	        ev.preventDefault();
	        $(ev.target).closest(draggables.selector).addClass('over');
	        return true;
	      },
	      'dragleave': function(ev){
	        ev.preventDefault();
	        $(ev.target).closest(draggables.selector).removeClass('over');
	        return true;
	      }
	    });
	    
	    
	    draggables.on({
	      'mousedown': function(ev){
	        $(ev.target).closest(draggables.selector).addClass('active');
	        return true;
	      },
	      'mouseup': function(ev){
	        $('.active').removeClass('active');
	        return true;
	      },
	      'dragstart': function(ev){
	        ev.originalEvent.dataTransfer.effectAllowed='move';
	        ev.originalEvent.dataTransfer.setData("Text", ev.target.getAttribute('id'));
	        ev.originalEvent.dataTransfer.setDragImage(ev.target,100,20);
	        return true;
	      },
	      'dragend': function(ev){
	        return true;
	      }
	    });
		
	  };

	  // A really lightweight plugin wrapper around the constructor, 
	  // preventing against multiple instantiations
	  $.fn[pluginName] = function ( options ) {
		return this.each(function () {
		  if (!$.data(this, 'plugin_' + pluginName)) {
			$.data(this, 'plugin_' + pluginName, new Plugin( this, options ));
		  }
		});
	  }

	}(jQuery, window));

	$(document).ready(function(){
	  $("#users").dragDrop({
			  draggableSelector: ".task",
			  droppableSelector: ".task-list",
	      appendToSelector: ".user-name"
		});
	  $("a.icon-trash").on("click", function(){
	    $(this).closest(".task").remove();
	  });
	  $("a.icon-ok").on("click", function(){
	    $(this).closest(".task").appendTo("#completed-tasks");
	    $("#completed-tasks").addClass('open');
	  });
	  $("a.icon-pencil").on("click", function(){
	    var task = $(this).closest(".task");
	    task.attr("draggable", "false");
	    task.find("p").attr("contenteditable", "true").on({
	        "keypress": function(ev){
	          if(ev.keyCode == 13)
	          {
	            ev.preventDefault();
	            $(this).attr("contenteditable", "false");
	            task.attr("draggable", "true");
	          }
	        },
	        "focusout": function(ev){
	          $(this).attr("contenteditable", "false");
	            task.attr("draggable", "true");
	        }
	    }).focus();
	  });
	});
	
	function clickSubmit( ){
		var spring=$('springForm').serializeArray();
		var t=0;
		t++;
	}
</script>
</head>
<body>
<%-- <form:form modelAttribute="tests" action="assignment" method="post"> --%>
<form:form commandName="assignmentBean" action="assignment" method="post" id="springForm">
<input type="submit" onclick="clickSubmit()">Done</input>  
asd
	<!-- JJ -->
<div id="page">
	<div id="workarea">
		<h1>Drag and Drop Tasks</h1>
		<div id="completed-tasks">
			<h3>
				<em class="icon-ok icon-large"></em> Completed Tasks
			</h3>	
		</div><!-- #completed-tasks -->
		<div id="users" class="user-panels">
			<div id="user-1" class="user-panel">
				<h4 class="user-name">John Doe</h4>
				<div class="toolbar">
					<a href="#" class="add-task icon icon-plus"></a>
				</div>
				<div class="task-list">
					<div id="task-1" class="task">
						<p>task 1</p>
						<div class="actions">
							<a href="#" class="icon-caret-right"></a>
							<a href="#" class="icon-ok"></a>
							<a href="#" class="icon-pencil"></a>
							<a href="#" class="icon-trash"></a>
						</div>
					</div>
					<div id="task-2" class="task">
						<p>task 2</p>
						<div class="actions">
							<a href="#" class="icon-caret-right"></a>
							<a href="#" class="icon-ok"></a>
							<a href="#" class="icon-pencil"></a>
							<a href="#" class="icon-trash"></a>
						</div>

					</div>
					<div id="task-3" class="task">
						<p>task 3</p>
						<div class="actions">
							<a href="#" class="icon-caret-right"></a>
							<a href="#" class="icon-ok"></a>
							<a href="#" class="icon-pencil"></a>
							<a href="#" class="icon-trash"></a>
						</div>

					</div>
					<div id="task-4" class="task">
						<p>task 4</p>
						<div class="actions">
							<a href="#" class="icon-caret-right"></a>
							<a href="#" class="icon-ok"></a>
							<a href="#" class="icon-pencil"></a>
							<a href="#" class="icon-trash"></a>
						</div>
					</div>
				</div>
			</div>
			<div id="user-2" class="user-panel">
				<h4 class="user-name">Jane Doe</h4>
				<div class="toolbar">
					<a href="#" class="add-task icon icon-plus"></a>
				</div>
				<div class="task-list">
					<div id="task-5" class="task">
						<p>task 5</p>
						<div class="actions">
							<a href="#" class="icon-caret-right"></a>
							<a href="#" class="icon-ok"></a>
							<a href="#" class="icon-pencil"></a>
							<a href="#" class="icon-trash"></a>
						</div>
					</div>
					<div id="task-6" class="task">
						<p>task 6</p>
						<div class="actions">
							<a href="#" class="icon-caret-right"></a>
							<a href="#" class="icon-ok"></a>
							<a href="#" class="icon-pencil"></a>
							<a href="#" class="icon-trash"></a>
						</div>
					</div>
					<div id="task-7" class="task">
						<p>task 7</p>
						<div class="actions">
							<a href="#" class="icon-caret-right"></a>
							<a href="#" class="icon-ok"></a>
							<a href="#" class="icon-pencil"></a>
							<a href="#" class="icon-trash"></a>
						</div>
					</div>
					<div id="task-8" class="task">
						<p>task 8</p>
						<div class="actions">
							<a href="#" class="icon-caret-right"></a>
							<a href="#" class="icon-ok"></a>
							<a href="#" class="icon-pencil"></a>
							<a href="#" class="icon-trash"></a>
						</div>
					</div>
				</div>
			</div>
			<div id="user-3" class="user-panel">
				<h4 class="user-name">Suzy Q</h4>
				<div class="toolbar">
					<a href="#" class="add-task icon icon-plus"></a>
				</div>
				<div class="task-list">
					<div id="task-9" class="task">
						<p>task 9</p>
						<div class="actions">
							<a href="#" class="icon-caret-right"></a>
							<a href="#" class="icon-ok"></a>
							<a href="#" class="icon-pencil"></a>
							<a href="#" class="icon-trash"></a>
						</div>
					</div>
					<div id="task-10" class="task">
						<p>task 10</p>
						<div class="actions">
							<a href="#" class="icon-caret-right"></a>
							<a href="#" class="icon-ok"></a>
							<a href="#" class="icon-pencil"></a>
							<a href="#" class="icon-trash"></a>
						</div>
					</div>
					<div id="task-11" class="task">
						<p>task 11</p>
						<div class="actions">
							<a href="#" class="icon-caret-right"></a>
							<a href="#" class="icon-ok"></a>
							<a href="#" class="icon-pencil"></a>
							<a href="#" class="icon-trash"></a>
						</div>
					</div>
					<div id="task-12" class="task">
						<p>task 12</p>
						<div class="actions">
							<a href="#" class="icon-caret-right"></a>
							<a href="#" class="icon-ok"></a>
							<a href="#" class="icon-pencil"></a>
							<a href="#" class="icon-trash"></a>
						</div>
					</div>
				</div>
			</div>
			${assignmentBean.users[0].id}
			<c:forEach items="${assignmentBean.users}" var="user" varStatus="ele">
			<div id="user-${user.id}" class="user-panel" align="left">
				<h4 class="user-name">${user.name}</h4>
				<form:hidden path="users[${ele.index}].id" value="${user.id}"/> 
				<div class="toolbar">
					<a href="#" class="add-task icon icon-plus"></a>
				</div>
				<div class="task-list">
				<c:forEach items="${user.tests}" var="test" varStatus="i">
					<div id="task-${test.testId} " class="task">
						<p>${test.testName}</p>
						<small>${test.testDesc}</small>
						 <form:hidden path="users[${ele.index}].tests[${i.index}].testId" value="${test.testId}"/>
						<div class="actions" align="left">
							<a href="#" class="icon-caret-right"></a>
							<a href="#" class="icon-ok"></a>
							<a href="#" class="icon-pencil"></a>
							<a href="#" class="icon-trash"></a>
						</div>
					</div></c:forEach>
					
				</div>
			</div>	</c:forEach>		
		</div><!-- #users -->
		
	</div><!-- #workarea -->
</div><!-- #page -->
<!-- SDG -->

</form:form>
</body>

</html>