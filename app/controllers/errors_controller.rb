class ErrorsController < ApplicationController

	def error_403
		render status: 403, layout: "error"
	end
end