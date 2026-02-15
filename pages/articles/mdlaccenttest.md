---
title: MDL Accent Coloring Test
permalink: MDL_Accent_Coloring_Test
---

me when the material design is lite (real)

<!-- Settings Toggles -->
<header>
    <label class="mdl-switch mdl-js-switch mdl-js-ripple-effect mdl-js-ripple-effect--ignore-events is-upgraded" for="darkModeToggle" data-upgraded=",MaterialSwitch,MaterialRipple">
        <input type="checkbox" id="darkModeToggle" class="mdl-switch__input">
        <span class="mdl-switch__label">Unchecked</span>
    <div class="mdl-switch__track"></div><div class="mdl-switch__thumb"><span class="mdl-switch__focus-helper"></span></div><span class="mdl-switch__ripple-container mdl-js-ripple-effect mdl-ripple--center" data-upgraded=",MaterialRipple"><span class="mdl-ripple"></span></span></label>
</header>
<header>
    <label class="mdl-switch mdl-js-switch mdl-js-ripple-effect is-checked mdl-js-ripple-effect--ignore-events is-upgraded" for="onekoToggle" data-upgraded=",MaterialSwitch,MaterialRipple">
        <input type="checkbox" id="onekoToggle" class="mdl-switch__input">
        <span class="mdl-switch__label">Checked</span>
    <div class="mdl-switch__track"></div><div class="mdl-switch__thumb"><span class="mdl-switch__focus-helper"></span></div><span class="mdl-switch__ripple-container mdl-js-ripple-effect mdl-ripple--center" data-upgraded=",MaterialRipple"><span class="mdl-ripple"></span></span></label>
</header>

<br>

<button class="mdl-button mdl-js-button mdl-button--fab mdl-button--colored">
  <i class="material-icons">add</i>
</button>

<!-- Colored raised button -->
<button class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored">
  Button
</button>

<!-- Accent-colored raised button -->
<button class="mdl-button mdl-js-button mdl-button--raised mdl-button--accent">
  Button
</button>
<br>
<!-- Wide card with share menu button -->
<style>
.demo-card-wide.mdl-card {
  width: 512px;
}
.demo-card-wide > .mdl-card__title {
  color: #fff;
  height: 176px;
  background: url('resources/img/articles/cometadv527/windows81.png') center / cover;
}
.demo-card-wide > .mdl-card__menu {
  color: #fff;
}
</style>

<div class="demo-card-wide mdl-card mdl-shadow--2dp">
  <div class="mdl-card__title">
    <h2 class="mdl-card__title-text">Welcome</h2>
  </div>
  <div class="mdl-card__supporting-text">
    Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    Mauris sagittis pellentesque lacus eleifend lacinia...
  </div>
  <div class="mdl-card__actions mdl-card--border">
    <a class="mdl-button mdl-button--colored mdl-js-button mdl-js-ripple-effect">
      Get Started
    </a>
  </div>
  <div class="mdl-card__menu">
    <button class="mdl-button mdl-button--icon mdl-js-button mdl-js-ripple-effect">
      <i class="material-icons">share</i>
    </button>
  </div>
</div>
<br>
<div class="mdl-progress mdl-js-progress mdl-progress__indeterminate"></div>
<br>
<div class="mdl-spinner mdl-spinner--single-color mdl-js-spinner is-active"></div>
<br>
<!-- Default Slider -->
<input class="mdl-slider mdl-js-slider" type="range"
  min="0" max="100" value="0" tabindex="0">
  <br>
  <label class="mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect" for="checkbox-1">
  <input type="checkbox" id="checkbox-1" class="mdl-checkbox__input" checked>
  <span class="mdl-checkbox__label">Checked</span>
</label>
<label class="mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect" for="checkbox-1">
  <input type="checkbox" id="checkbox-1" class="mdl-checkbox__input">
  <span class="mdl-checkbox__label">Unchecked</span>
</label>
<br>
<label class="mdl-radio mdl-js-radio mdl-js-ripple-effect" for="option-1">
  <input type="radio" id="option-1" class="mdl-radio__button" name="options" value="1" checked>
  <span class="mdl-radio__label">First</span>
</label>
<label class="mdl-radio mdl-js-radio mdl-js-ripple-effect" for="option-1">
  <input type="radio" id="option-1" class="mdl-radio__button" name="options" value="1">
  <span class="mdl-radio__label">First</span>
</label>
<br>
<label class="mdl-icon-toggle mdl-js-icon-toggle mdl-js-ripple-effect" for="icon-toggle-1">
  <input type="checkbox" id="icon-toggle-1" class="mdl-icon-toggle__input" checked>
  <i class="mdl-icon-toggle__label material-icons">format_bold</i>
</label>
<label class="mdl-icon-toggle mdl-js-icon-toggle mdl-js-ripple-effect" for="icon-toggle-1">
  <input type="checkbox" id="icon-toggle-1" class="mdl-icon-toggle__input">
  <i class="mdl-icon-toggle__label material-icons">format_bold</i>
</label>
<br>


<table class="mdl-data-table mdl-js-data-table mdl-data-table--selectable mdl-shadow--2dp">
  <thead>
    <tr>
      <th class="mdl-data-table__cell--non-numeric">Codename</th>
      <th class="mdl-data-table__cell--non-numeric">Preliminary Name</th>
      <th class="mdl-data-table__cell--non-numeric">Final Release</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td class="mdl-data-table__cell--non-numeric">Revolution</td>
      <td class="mdl-data-table__cell--non-numeric">-</td>
      <td class="mdl-data-table__cell--non-numeric">Wii</td>
    </tr>
    <tr>
      <td class="mdl-data-table__cell--non-numeric">Project Reality</td>
      <td class="mdl-data-table__cell--non-numeric">Nintendo Ultra 64</td>
      <td class="mdl-data-table__cell--non-numeric">Nintendo 64</td>
    </tr>
    <tr>
      <td class="mdl-data-table__cell--non-numeric">Home Video Computer</td>
      <td class="mdl-data-table__cell--non-numeric">Advanced Video System</td>
      <td class="mdl-data-table__cell--non-numeric">Nintendo Entertainment System</td>
    </tr>
  </tbody>
</table>
<br>
<form action="#">
  <div class="mdl-textfield mdl-js-textfield">
    <input class="mdl-textfield__input" type="text" id="sample1">
    <label class="mdl-textfield__label" for="sample1">Text...</label>
  </div>
</form>
<br>
<form action="#">
  <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
    <input class="mdl-textfield__input" type="text" id="sample3">
    <label class="mdl-textfield__label" for="sample3">Text...</label>
  </div>
</form>
<br>
<div class="material-icons mdl-badge mdl-badge--overlap" data-badge="1">account_box</div>
