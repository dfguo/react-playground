FilterableProductTable = React.createClass
  getInitialState: () ->
    {
      filterText: 'ball',
      inStockOnly: false
    }

  render: () ->
    `<div>
      <SearchBar
        filterText={this.state.filterText}
      />
      <ProductTable
        filterText={this.state.filterText}
        inStockOnly={this.state.inStockOnly}
        products={this.props.products}
      />
    </div>`

SearchBar = React.createClass
  render: () ->
    `<form>
      <input type="text" placeholder="Searching..." value={this.props.filterText} />
      <p>
        <input type="checkbox" checked={this.props.inStockOnly} />
        {' '}
        Only show products in stock
      </p>
    </form>`


ProductTable = React.createClass
  render: () ->
    rows = []
    lastCategory = null
    @props.products.forEach (product) =>
      if product.name.indexOf(@props.filterText) == -1 || (!product.stocked && @props.inStockOnly)
        return
      if (product.category != lastCategory)
        rows.push(
          `<ProductCategoryRow category={product.category} key={product.category} />`
        )
      rows.push(
        `<ProductRow product={product} key={product.name} />`
      )
      lastCategory = product.category

    `<table>
      <th>
        <td>Name</td>
        <td>Price</td>
      </th>
      <tbody>{rows}</tbody>
    </table>`

ProductCategoryRow = React.createClass
  render: () ->
    `<tr>
      <td colSpan="2">{this.props.category}</td>
    </tr>`

ProductRow = React.createClass
  render: () ->
    `<tr>
      <td>{this.props.product.name}</td>
      <td>{this.props.product.price}</td>
    </tr>`

$ () ->
  data = [
    {category: "Sporting Goods", price: "$49.99", stocked: true, name: "Football"},
    {category: "Sporting Goods", price: "$9.99", stocked: true, name: "Baseball"},
    {category: "Sporting Goods", price: "$29.99", stocked: false, name: "Basketball"},
    {category: "Electronics", price: "$99.99", stocked: true, name: "iPod Touch"},
    {category: "Electronics", price: "$399.99", stocked: false, name: "iPhone 5"},
    {category: "Electronics", price: "$199.99", stocked: true, name: "Nexus 7"}
  ]

  React.render(
    `<FilterableProductTable products={data} />`,
    document.getElementById('content')
  )
