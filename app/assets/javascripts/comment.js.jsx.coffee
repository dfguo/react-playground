CommentBox = React.createClass
  getInitialState: () ->
    {
      data: []
    }
  componentDidMount: () ->
    data = [
      {author: "Pete Hunt", text: "This is one comment"},
      {author: "Jordan Walke", text: "This is *another* comment"}
    ]
    @setState({data: data})

  handleCommentSubmit: (comment) ->
    data = @state.data
    data.concat([comment])
    @setState(data: data)

  render: ->
    `<div className="commentBox">
      <h1>Comments</h1>
      <CommentList data={this.state.data} />
      <CommentForm onCommentSubmit={this.handleCommentSubmit} />
    </div>`

CommentList = React.createClass
  render: () ->
    commentNodes = this.props.data.map (comment) ->
      `<Comment author={comment.author}>{comment.text}</Comment>`
    `<div className="commentList">
      {commentNodes}
    </div>`

CommentForm = React.createClass
  handleSubmit: (e) ->
    e.preventDefault()
    author = @refs.author.getDOMNode().value.trim()
    text = @refs.text.getDOMNode().value.trim()
    return if !text or !author
    # add data to CommentBox
    @props.onCommentSubmit({author: author, text: text})
    @refs.author.getDOMNode().value = ''
    @refs.text.getDOMNode().value = ''

  render: ->
    `<form className="commentForm" onSubmit={this.handleSubmit}>
      <input type="text" placeholder="Your name" ref="author" />
      <input type="text" placeholder="Say something..." ref="text" />
      <input type="submit" value="Post" />
    </form>`

converter = new Showdown.converter()
Comment = React.createClass
  render: ->
    rawMarkup = converter.makeHtml(this.props.children.toString())
    `<div className="comment">
      <h2 className="commentAuthor">
        {this.props.author}
      </h2>
      <span dangerouslySetInnerHTML={{__html: rawMarkup}} />
    </div>`

$ () ->
  data = [
    {author: "Pete Hunt", text: "This is one comment"},
    {author: "Jordan Walke", text: "This is *another* comment"}
  ]
  React.render(
    `<CommentBox data={data} />`,
    document.getElementById('content')
  )
