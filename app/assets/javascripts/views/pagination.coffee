class App.Views.Pagination extends Backbone.View
  initialize: (options) ->
    @collection.on 'sync', => @render()
  template: JST['templates/pagination']
  tagName: 'ul'
  render: ->
    @$el.html(@template())
    @$('.page-back').toggleClass('disabled', @isFirstPage())
    @$('.page-forward').toggleClass('disabled', @isLastPage())
    @$(".page").toggleClass('active', false)
    @$(".page[data-page=#{@collection.page}]").toggleClass('active', true)
    this
  gotoPageIndex: (pageIndex) ->
      offset = pageIndex * @collection.limit
      data = _.defaults({offset:offset}, @collection.fetchDefaults)
      @collection.fetch(data:data)
  events:
    'click li.page': (e) ->
      e.preventDefault()
      page = $(e.target).parent().data('page')
      return if page is @collection.page
      pageIndex = page - 1
      @gotoPageIndex(pageIndex)
    'click li.page-last': (e) ->
      e.preventDefault()
      lastPageIndex = @collection.pages - 1
      @gotoPageIndex(lastPageIndex)
    'click li.page-back ': (e) ->
      e.preventDefault()
      return if @isFirstPage()
      prevPageIndex = @collection.page - 2
      @gotoPageIndex(prevPageIndex)
    'click li.page-first': (e) ->
      e.preventDefault()
      firstPageIndex = 0
      @gotoPageIndex(firstPageIndex)
    'click li.page-forward': (e) ->
      e.preventDefault()
      return if @isLastPage()
      nextPageIndex = @collection.page
      @gotoPageIndex(nextPageIndex)
  isFirstPage: -> @collection.page == 1
  isLastPage: -> @collection.page == @collection.pages
