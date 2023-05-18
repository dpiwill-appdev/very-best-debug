class VenuesController < ApplicationController
  def index
    matching_venues = Venue.all
    @venues = matching_venues.order(:created_at)

    render({ :template => "venue_templates/venue_list.html.erb" })
  end

  def show
    venue_id = params.fetch("an_id")
    @the_venue = Venue.where({ :id => venue_id }).first
    matching_comments = Comment.all
    @list_of_comments = Comment.where({ venue_id: venue_id }).order({ created_at: :desc })

    if @the_venue == nil
      redirect_to("/404")
    else
      render({ :template => "venue_templates/details.html.erb" })
    end
  end

  def create
    addy = params.fetch("query_address")
    name = params.fetch("query_name")
    hood = params.fetch("query_neighborhood")

    venue = Venue.new
    venue.name = name
    venue.address = addy
    venue.neighborhood = hood
    venue.save

    redirect_to("/venues/#{venue.id}")
  end

  def update
    the_id = params.fetch("the_id")

    venue = Venue.where({ :id => the_id }).first
    venue.address = params.fetch("query_address")
    venue.name = params.fetch("query_name")
    venue.neighborhood = params.fetch("query_neighborhood")
    venue.save

    redirect_to("/venues/#{venue.id}")
    #render({ :template => "venue_templates/update.html.erb" })
  end

  def destroy
    the_id = params.fetch("id_to_delete")
    matching_venues = Venue.where({ :id => the_id })
    venue = matching_venues.first
    venue.destroy

    redirect_to("/venues")
    #render({ :template => "venue_templates/delete.html.erb" })
  end
end
