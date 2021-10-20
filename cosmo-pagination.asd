
(require "asdf")
(asdf:defsystem "cosmo-pagination"
  :version "0.1"
  :author "vindarel"
  :license "GPL3"
  :depends-on (
               :str
               :serapeum

               ;; dev
               :log4cl
               )
  :components ((:module "src"
                :components
                ((:file "package")
                 (:file "pagination"))))


  :description "Cosmo framework pagination helper."
  ;; :long-description
  ;; #.(read-file-string
  ;;    (subpathname *load-pathname* "README.md"))
  :in-order-to ((test-op (test-op "cosmo-pagination-test"))))
