---
mode: 'agent'
model: GPT-4o
tools: ['extensions', 'codebase', 'usages', 'vscodeAPI', 'problems', 'changes', 'testFailure', 'terminalSelection', 'terminalLastCommand', 'openSimpleBrowser', 'fetch', 'findTestFiles', 'searchResults', 'githubRepo', 'runTests', 'runCommands', 'runTasks', 'editFiles', 'runNotebooks', 'search', 'new', 'dart_format', 'get_widget_tree', 'pub']
description: 'Create a new component'
---

Your goal is to create a component, ask the user for the component name, and then generate the necessary files and code structure for the new component.

The component should follow the following structure:

```
/component-name
    /screens
    /widgets
    /models
    /providers
```

In the screens folder, create a new file called `component_name_screen.dart`. This file will contain the UI for the component.

In the widgets folder, create a new file called `component_name_widget.dart`. This file will contain the reusable widget for the component.

In the models folder, create a new file called `component_name_model.dart`. This file will contain the data model for the component.

In the providers folder, create a new file called `component_name_provider.dart`. This file will contain the state management logic for the component.

You will also create the tests for the component in a new folder called `tests`. Inside the tests folder, create a new file called `component_name_test.dart`. This file will contain the unit tests for the component.