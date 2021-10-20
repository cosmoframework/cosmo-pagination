
# Pagination


~~~lisp
(make-pagination :page 1
    :page-size 50
    :nb-elements (length '(:my :results)))
=>
(dict
  :PAGE 1
  :NB-ELEMENTS 2
  :PAGE-SIZE 200
  :NB-PAGES 1
  :MAX-NB-BUTTONS 1
  :TEXT-LABEL "Page 1 / 1"
 )
~~~

Then give this object to the template to create the pagination buttons.

Use the default template:

~~~html
// with Djula
{% include "your/includes/pagination.html" :pagination pagination-object %}
~~~

![](pagination.png)

## TODOs

- customize href link in template.
