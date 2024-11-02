
# Pagination

Helps build the pagination buttons in a (web) app. Includes a ready-to-use Djula template with Bulma CSS.

Steps:

1. create a pagination object
2. generate the HTML

~~~lisp
(make-pagination :page 1
    :page-size 50
    :nb-elements (length '(:my :results))
    :href (format "search?q=~a" query))
=>
(dict
  :PAGE 1
  :NB-ELEMENTS 2
  :HREF "search?q=foo"
  :PAGE-SIZE 200
  :NB-PAGES 1
  :MAX-NB-BUTTONS 1
  :TEXT-LABEL "Page 1 / 1"
 )
~~~

Then give this object to the template to create the pagination buttons.

The `href` will be expanded with a `&page=` and the current page. So, at the time of writing, you must add a "?q=" part. PR and discussion welcome. It works for now©.

## Install

Clone and `(ql:quickload "cosmo-pagination")`.

In Ultralisp.

## Use in templates

You can pass the pagination object to your template and build the HTML
list of buttons yourself.

See our ready-to-use template below.

* `pagination.href`: the URL for a page button. You can append `&page=n` to it (see below).

* `pagination.page`: the current page. If it is 1, you might disable the "previous" button. For example:

```html
          {% if pagination.page == 1 %}
          <a class="pagination-link" aria-label="Goto previous page" disabled> < </a>
          {% else %}
          <a class="pagination-link" aria-label="Goto previous page"
             href="{{ pagination.href }}&page=1"> < </a>
          {% endif %}
```

* `pagination.nb-elements`: the total number of elements in your sequence that you want to paginate.
* `pagination.nb-pages`: the total number of pages.
* `pagination.page-size`: the page size, the number of elements to display on one page. Defaults to 200.
* `pagination.max-nb-buttons`: the total number of buttons we want to display. Defaults to 5. You'll want to iterate over it at some point. We do like this in Djula templates:

```html
          {% for _ in pagination.max-nb-buttons.make-list %}
```

Then, you can check which page you are on with this, in order to emphasize this button:

```html
          {% if forloop.counter == pagination.page %}
```

* `pagination.text-label`: the text to show on buttons. Defaults to "Page 1 / n", where 1 and n are filled appropriately. Optional.


## Default template

Use the default template:

~~~html
// with Djula
{% include "pagination.html" :pagination pagination-object %}
~~~

![](pagination.png)

You might want to tell Djula where to find the template before use in
your app:

~~~lisp
(djula:add-template-directory (asdf:system-relative-pathname :cosmo-pagination
                                                             "src/templates/"))
~~~

## Dev

Here's a snippet to query a DB with Mito and paginate the results:

```lisp
(defun table-records (table &key (page 1) (page-size *page-size*))
  (let ((offset (* (1- page) page-size)))
    (mito:select-dao table
      (sxql:order-by (:desc :created-at))
      (sxql:limit page-size)
      (sxql:offset offset))))
```

## Changelog

- <2024-02-28> Added the `:href` argument to customize button links in the template.
