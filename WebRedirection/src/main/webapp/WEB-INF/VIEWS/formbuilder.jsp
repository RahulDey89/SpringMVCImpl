<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script>
<script src="http://cdnjs.cloudflare.com/ajax/libs/angular.js/1.3.10/angular.min.js"></script>
<link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css" rel="stylesheet">
      
<style type="text/css">
@charset "UTF-8";
body, html {
  height: 100%;
  font-size: 100%;
  line-height: 1.2;
}

.top-btn {
  margin-right: 0.5em;
}

.container {
  margin-top: 1em;
  background: #fff;
}

ul {
  list-style: none;
  padding: 0;
}

li {
  list-style: none;
  margin-left: 2em;
  margin-bottom: 0.5em;
  padding: 0.5em 1em;
  border: 1px solid #ccc;
  background: #eee;
  cursor: move;
  border-radius: 5px;
}

.survey-canvas {
  border: 3px dashed #eee;
  padding: 1em;
  list-style: none;
}

.survey-canvas li {
  border: 0;
  background: 0;
  padding: 0;
  margin: 0;
  margin-bottom: 2em;
  cursor: initial;
}
.survey-canvas li h4 {
  margin-bottom: 0.5em;
  margin-left: 0;
  font-size: 1.2em;
  border: 1px solid #eee;
  padding: 0.5em 1em;
  border-radius: 5px;
  cursor: move;
  color: #ccc;
  font-weight: 300;
  text-transform: uppercase;
  font-size: 0.8em;
  letter-spacing: 2px;
}
.survey-canvas li h4::before {
  content: '::';
  color: #eee;
  margin-right: 0.5em;
}
.survey-canvas li .x {
  float: right;
  cursor: pointer;
  color: #eee;
  margin-top: -0.3em;
  font-size: 1.8em;
}
.survey-canvas li .x:hover {
  color: red;
}
.survey-canvas li .question-container {
  margin-left: 1em;
}

.placeholder {
  font-size: 1.5em;
  color: #ccc;
  text-align: center;
  padding-top: 100px;
  padding-bottom: 100px;
  vertical-align: middle;
  letter-spacing: 1px;
}

.survey-textbox, .survey-textarea {
  display: block;
  width: 100%;
}

.new-page {
  text-align: center;
  color: #ccc;
  text-transform: uppercase;
  margin-bottom: -1em;
  letter-spacing: 1px;
  font-size: 90%;
}

.default-text {
  background: none;
  border: none;
  padding: 0.2em;
  resize: none;
}
.default-text i.fa-pencil {
  display: none;
  font-size: 0.6em;
  padding-left: 0.5em;
  vertical-align: middle;
  color: green;
}
.default-text:hover {
  background: #eee;
  border-bottom: 1px dashed green;
}
.default-text:hover i.fa-pencil {
  display: inline;
}

.ui-state-default {
  border-color: lightblue;
}

.ui-state-hover {
  border-color: lightgreen;
}

footer {
  text-align: center;
  margin-top: 2em;
  margin-bottom: 1em;
  color: #ccc;
  letter-spacing: 2px;
}

hr.divider {
  padding: 0;
  border: none;
  border-top: medium double #333;
  color: #333;
  text-align: center;
}
hr.divider:after {
  content: "§";
  display: inline-block;
  position: relative;
  top: -0.7em;
  font-size: 1.5em;
  padding: 0 0.25em;
  background: white;
}

</style>

<script type="text/javascript">
'use strict';

/**
 *  !TODO
 *     0)  add indicators for editable text
 *     1)  refactor/neaten codebase
 *     2)  move to angular
 *     3)  add event watcher for $canvas change
 *            - attach save to that watcher
 *     4)  add preview
 */

(function ($, angular) {
  var app = angular.module('SurveyBuilder', []);

  $(document).ready(function () {
    var $surveyComponent = $('#survey-components li');
    var $canvas = $('#survey-canvas');
    var $placeholder = $('<p>Drag survey components here<br/>or click to add</p>').addClass('placeholder');

    function saveSurvey() {
      var $saveBtn = $('#save-status');
      if ($saveBtn.hasClass('btn-warning')) {
        $saveBtn.html('<i class="fa fa-check-circle"></i> Saved!');
        $saveBtn.removeClass('btn-warning').addClass('btn-success');
      }
    }

    function unsaveSurvey() {
      var $saveBtn = $('#save-status');
      if ($saveBtn.hasClass('btn-success')) {
        $saveBtn.html('<i class="fa fa-exclamation-circle"></i> Not Saved');
        $saveBtn.removeClass('btn-success').addClass('btn-warning');
      }
    }

    $('#save-status').click(function (e) {
      saveSurvey();
      // save every 30 seconds
      setInterval(saveSurvey, 30000);
    });

    $canvas.html($placeholder);
    function makeSurveyComponent(componentType) {
      var $component = $('<li></li>');
      var $x = $('<span></span>').addClass('x').text('×');
      var $header = $('<h4></h4>').text(componentType).append($('<span></span>').addClass('x').text('×'));
      var $container = $('<div></div>').addClass('question-container'),
          $question = undefined,
          $inputElement = undefined;

      $component.append($header);

      var random = undefined;
      switch (componentType) {
        case 'Textbox':
          $question = $('<label></label>').addClass('default-text').text('Textbox question').attr('contenteditable', 'true');;
          $inputElement = $('<input />').addClass('form-control');
          break;
        case 'Text Area':
          $question = $('<label></label>').addClass('default-text').text('Text area question').attr('contenteditable', 'true');
          $inputElement = $('<textarea />').addClass('form-control');
          break;
        case 'Checkboxes':
          random = Math.floor(Math.random() * 100);
          $question = $('<label></label>').addClass('default-text').text('Checkbox question').attr('contenteditable', 'true');
          $inputElement = $('<div></div>').addClass('survey-checkbox').append('<input type="checkbox" name="q-' + random + '" value="1"> <span contenteditable=true>Option 1</span><br>').append('<input type="checkbox" name="q-' + random + '" value="2"> <span contenteditable=true>Option 2</span><br>').append('<input type="checkbox" name="q-' + random + '" value="3"> <span contenteditable=true>Option 3</span><br>');
          break;
        case 'Radio Buttons':
          random = Math.floor(Math.random() * 100);
          $question = $('<label></label>').addClass('default-text').text('Radio button question').attr('contenteditable', 'true');
          $inputElement = $('<div></div>').addClass('survey-radio').append('<input type="radio" name="q-' + random + '" value="1"> <span contenteditable=true>Option 1</span><br>').append('<input type="radio" name="q-' + random + '" value="2"> <span contenteditable=true>Option 2</span><br>').append('<input type="radio" name="q-' + random + '" value="3"> <span contenteditable=true>Option 3</span><br>');
          break;
        case 'Select Box':
          $question = $('<p></p>').addClass('default-text').text('Select box question').attr('contenteditable', 'true');
          $inputElement = $('<select></select>').addClass('survey-select').append('<option value="1">Option 1</option>').append('<option value="2">Option 2</option>').append('<option value="3">Option 3</option>');
          break;
        case 'Button':
          var $button = $('<button></button>').addClass('btn btn-default btn-lg btn-block').text('Submit');
          $component.append($button);
          break;
        case 'Heading':
          $question = $('<h3>Large Heading</h3>').addClass('default-text').attr('contenteditable', 'true');
          break;
        case 'Text':
          $question = $('<div></div>').attr('contenteditable', 'true').text('Fusce et ultricies neque. Vestibulum eu vehicula augue. In a molestie elit. Ut massa mi, lobortis volutpat orci id, tempor ornare sapien. Maecenas sapien nunc, iaculis id odio in, elementum maximus erat. Curabitur nec metus eget tortor luctus scelerisque.');
          break;
        case 'Horizontal Line':
          $component.append('<hr class="divider"/>');
          break;
        case 'New Page':
          $component.append('<div class="new-page">New Page</div><hr/>');
          break;
      }

      $container.append($question).append($inputElement);
      $component.append($container);
      return $component;
    }

    $('#reset').click(function () {
      $canvas.html($placeholder);
      unsaveSurvey();
    });

    $surveyComponent.click(function (e) {
      $canvas.find(".placeholder").remove();
      makeSurveyComponent($(this).text()).appendTo($canvas);

      var $x = $('.x'); // DRY 0
      $x.click(function (e) {
        var $component = $(this).parent().parent();
        $component.remove();
        var $container = $('.survey-canvas');
        if ($container.children('li').length === 0) {
          $container.append($placeholder);
        }
        unsaveSurvey();
      });
      unsaveSurvey();
    });

    $surveyComponent.draggable({
      appendTo: "body",
      helper: "clone",
      cursorAt: { top: 15, left: 15 }
    });

    /*start: (e, ui) => $(ui.helper).addClass('ui-state-dragging'),
    stop: (e, ui) => $(ui.helper).removeClass('ui-state-dragging'),*/
    $canvas.droppable({
      activeClass: "ui-state-default",
      hoverClass: "ui-state-hover",
      accept: ":not(.ui-sortable-helper)",
      drop: function drop(event, ui) {
        $(this).find(".placeholder").remove();
        makeSurveyComponent(ui.draggable.text()).appendTo(this);

        var $x = $('.x'); // DRY 0
        $x.click(function (e) {
          var $component = $(this).parent().parent();
          $component.remove();
          var $container = $('.survey-canvas');
          if ($container.children('li').length === 0) {
            $container.append($placeholder);
          }
          unsaveSurvey();
        });
        unsaveSurvey();
      }
    }).sortable({
      items: "li:not(.placeholder)",
      cursorAt: { top: 20, left: 15 },
      handle: "h4",
      sort: function sort() {
        // gets added unintentionally by droppable interacting with sortable
        // using connectWithSortable fixes this, but doesn't allow you to customize active/hoverClass options
        $(this).removeClass("ui-state-default");
      }
    });
  });
})(jQuery, angular);
</script>
</head>
<body>
<div class="container" ng-app="SurveyBuilder">
  <h1>Survey Builder</h1>
  
  <div class="row">
    <button id="save-status" class="btn btn-warning pull-right"><i class="fa fa-exclamation-circle"></i> Click to Save Survey</button>
    
    <button id="preview" class="top-btn btn btn-default pull-right">Preview</button>
    
    <button id="publish" class="top-btn btn btn-default pull-right">Publish</button>
    <!-- left sidebar -->
    <div class="col-sm-4 survey-elements">
      <ul class="survey-components" id="survey-components">
        <h4>Basic Components</h4>
        <li>Textbox</li>
        <li>Text Area</li>
        <li>Checkboxes</li>
        <li>Radio Buttons</li>
        <li>Select Box</li>
        <!--<li>Button</li>-->
        
        <h4>Structure</h4>
        <li>Heading</li>
        <li>Text</li>
        <li>Horizontal Line</li>
        <li>New Page</li>
      </ul>
      <br/>
      <button id="reset" class="btn btn-default btn-block">Reset Survey</button>
      <br/>
    </div>
    <!-- right main canvas -->
    <div class="col-sm-8">
      <h2>
        <span="title" class="default-text" contenteditable="true">Your Survey</span> 
        <small contenteditable="false">created by you</small>
        <i class="fa fa-pencil"></i>
      </h2>
      <ul id="survey-canvas" class="survey-canvas">
      </ul>
      
      <button class="btn btn-default btn-lg btn-block">Submit</button>
    </div>
  </div>
</div>

<footer class="container"></footer>

</body>
</html>