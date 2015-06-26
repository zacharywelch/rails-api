module Jbuilder::Paging
  def paginate!(collection = [], *args)
    raise "paginate! needs paginated collection" unless _paginated?(collection)
    set! :limit, collection.limit_value
    set! :offset, collection.offset_value
    set! :total, collection.total_count
    set! :collection, collection, *args
  end

  def _paginated?(collection)
    collection.respond_to? :total_pages
  end
end
