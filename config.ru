require "json"
require "rack"

class Explorer

  def call(env)
    request = Rack::Request.new(env)

    if request.post?
      write_body(request)
      empty_response
    else
      challenge_response(request)
    end
  end

  private

  def empty_response
    [200, {}, ['']]
  end

  def challenge_response(request)
    [200, {}, [request.params["hub.challenge"]]]
  end

  def write_body(request)
    body = pretty(request.body.read)
    File.write(filepath, body)
  end

  def pretty(json_str)
    JSON.pretty_generate(JSON.parse(json_str))
  rescue
    json_str
  end

  def filepath

    now = Time.now
    "./pushes/#{now.to_i}.#{now.usec}.json"
  end

end

run Explorer.new
