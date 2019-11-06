---
marp: true
theme: uncover
---

# Almost Octane

Ember Octane is REALLY close

---

<!-- backgroundColor: beige -->

## What is Octane

- Octane is an Ember "edition"
- group of changes, most of them already present
- simpler, more JS less magic
- almost everything we asked for
- almost..
- PODS and Routable components are missing :(

---

# <!--fit--> :+1:

---

## AngleBrackets components

- `<AngleBrackets>` component invocation is here

---

# No JQuery by default

```
$ ember feature:disable jquery-integration
```

---

# No application template wrapper

```
$ ember feature:disable application-template-wrapper
```

- goodbye `<div class="ember-view"></div>`

---

# Native JS classes

```javascript
Route.extend({..})
Controller.extend({})
```

becomes

```javascript
class extends Route {...}
class extends Controller {...}
```
- `constructor` instead of `init`

---

# Native JS classes - Decorators

- Native classes require use of Decorators

```javascript
// apply to classes
@tagName
@classNames
```

---

# Decorators

```javascript
// apply to methods
@computed('X','Y')
get myProp() {
  // impl
}
```

```javascript
@action
myAction() {
  // impl
}
```

---

# Tracked properties

- State that can mutate the output is decorated as `@tracked`
- no need to use `this.set` anymore
- you annotate the values that are trackable instead of the end property

---

# Tracked properties

```javascript
import { tracked } from '@glimmer/tracking';

class Person {
  @tracked firstName;
  @tracked lastName;

  get fullName() {
    return `${this.firstName} ${this.lastName}`;
  }
}
```

---

# Glimmer components

```javascript
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

export default class Todo extends Component {
  @tracked completed;
}
```

---

# Glimmer components

- they describe the whole element (not only the inner element)
- subclass `@glimmer/components`
- no `extend`, `reopenClass`, `init`
- only `constructor` and `willDestroy` hooks
- all arguments in `this.args` and they are *immutable*

---

# Glimmer components

- No hooks!
- use `modifiers` from `ember-render-modifiers`

```
<div
  {{did-insert this.setColor @color}}
  {{did-update this.setColor @color}}
>
```

---

# Template only components

- No js component class by default
- (opt in feature flag)
- `this` is `null`
- you can only use `@argName`

```
{{!--
  This does not work, since `this` does not exist
--}}
<label for="title">Title</label>
<Input @value={{this.value}} id="title" />
```

---

# @action, {{on}} and {{fn}}

- `{{action}}` helper is gone
- @action decorator - binds a method to the context its used in
- `{{on}}` modifier - used to add event listeners to DOM elements
- `{{fn}}` helper - adds arguments to another function or callback

---

# @action

```javascript
import Component from '@glimmer/component';

export default class Example extends Component {
  @action
  doSomething() {
    // ...
  }
}
```

```
<button {{on "click" this.doSomething}}>Click Me!</button>
```


---

# {{on}}

- The API for {{on}} is the same as JavaScript's native `addEventListener`

```javascript
import Component from '@glimmer/component';
import { action } from '@ember/object';

export default class Example extends Component {
  @action
  handleClick(event) {
    event.preventDefault();
  }
}
```

```
<button {{on "click" this.handleClick}}>Click Me!</button>
```

---

# {{fn}}

- If you want to pass additional parameters to the callback function, you must use the {{fn}} helper.

```
<button {{on "click" (fn this.handleClick 123)}}>Click Me!</button>
```

---

# Observers are async

- let them go seem to be the answer
- if you can refactor them to be async
- if you can't wait :/
- [@pzuraq blog post](https://www.pzuraq.com/ember-octane-update-async-observers/)

---

# Required `this`

- references to properties *must* be `{{this.propertyName}}`

---

# <!--fit--> 🤔

---

# How to migrate

---
# move away from observers
---
# start using `@tracked`
---
# move to angle-brackets syntax
---
# move to explicit `this`
---
# migrate to `@tagName('')`
* wrap your component in a root element
* change `@classNames` to `class="..."`
* change `classNameBindings` to `class="{{...}}"`
* change `attributeBindings` to `attr={{...}}`
* change methods like `click` to `{{on "click"}}`
* move DOM manipulation to `modifiers`
---

# migrate to `@action`
- migrate `{{action}}` to `{{on}}` + `@action`

---

# migrate to native classes
---

# migrate `.set` to `@tracked`

---
# Notes

- you can do this in steps
- you probably should do this in steps
- @ PN we convert a few files at the time, based on what we work on

---

# <!--fit--> 🔥 Fin

---
## References

- [@melsumner slides](https://noti.st/melsumner/Hl16PZ/hands-on-with-ember-octane#szckVnl)
- [guides](https://octane-guides-preview.emberjs.com/release/upgrading/current-edition/cheat-sheet/)

---

# Demo December

## Thursday 5th

## Sign up!

