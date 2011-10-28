#   Copyright (c) 2010-2011, Diaspora Inc.  This file is
#   licensed under the Affero General Public License version 3 or later.  See
#   the COPYRIGHT file.

class Api::V0::PostsController < ApplicationController
  def show
    post = Post.find_all_by_type(params[:type])
    render :json => Api::V0::Serializers::Post.new(params[:t])
  end
end
