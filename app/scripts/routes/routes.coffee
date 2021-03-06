window.Routes =
  products_image_delete_path: (id) -> gon.root_url + '/products/images/'+id

  # Operator categories (на основе http://api.kormilica.info/#!/operator)
  operator_product_url:      (id) -> gon.root_url + '/products/' + id
  operator_product_edit_url: (id) -> gon.root_url + '/products/' + id + '/edit'
  operator_product_new_url:       -> gon.root_url + '/products/new'

  operator_categories_new_url:    (parentId) -> gon.root_url + '/categories/new?parent_id=' + parentId
  operator_categories_edit_url: (categoryId) -> gon.root_url + '/categories/' + categoryId + '/edit'

  products_by_category_url:   (id) -> gon.root_url + '/products?category_id=' + id