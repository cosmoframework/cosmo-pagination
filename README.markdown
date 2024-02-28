
# Pagination

Helps build a pagination list of buttons.

Defaults to using Bulma CSS.

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

Use the default template:

~~~html
// with Djula
{% include "your/includes/pagination.html" :pagination pagination-object %}
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
