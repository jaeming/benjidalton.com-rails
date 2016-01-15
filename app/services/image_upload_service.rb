class ImageUploadService
  require 'json'
  require 'net/http'
  require 'digest/sha1'

  def self.upload(file)
    #request API Authorization
    authorization_response = ImageUploadService.authorize_account
    auth_token = authorization_response["authorizationToken"]
    api_url = authorization_response["apiUrl"]
    download_url = authorization_response["downloadUrl"]

    #request upload URL & upload token
    upload_response = ImageUploadService.get_upload_url(auth_token, api_url)
    upload_url = upload_response["uploadUrl"]
    upload_token = upload_response["authorizationToken"]

    #upload image
    upload_response = ImageUploadService.upload_image(upload_url, file, upload_token)
    image_id = upload_response["fileId"]

    #return uploaded image url
    "#{download_url}/b2api/v1/b2_download_file_by_id?fileId=#{image_id}"
  end

  def self.authorize_account
    account_id = ENV["b2_account_id"]
    application_key = ENV["b2_application_key"]
    uri = URI("https://api.backblaze.com/b2api/v1/b2_authorize_account")
    req = Net::HTTP::Get.new(uri)
    req.basic_auth(account_id, application_key)
    http = Net::HTTP.new(req.uri.host, req.uri.port)
    http.use_ssl = true
    res = http.start {|http| http.request(req)}
    case res
    when Net::HTTPSuccess then
        json = res.body
    when Net::HTTPRedirection then
        fetch(res['location'], limit - 1)
    else
        res.error!
    end
    JSON.parse(json)
  end

  def self.get_upload_url(account_authorization_token, api_url)
    bucket_id = ENV["b2_bucket_id"]
    uri = URI("#{api_url}/b2api/v1/b2_get_upload_url")
    req = Net::HTTP::Post.new(uri)
    req.add_field("Authorization","#{account_authorization_token}")
    req.body = "{\"bucketId\":\"#{bucket_id}\"}"
    http = Net::HTTP.new(req.uri.host, req.uri.port)
    http.use_ssl = true
    res = http.start {|http| http.request(req)}
    case res
    when Net::HTTPSuccess then
        json = res.body
    when Net::HTTPRedirection then
        fetch(res['location'], limit - 1)
    else
        res.error!
    end
    JSON.parse(json)
  end

  def self.upload_image(upload_url, local_file, upload_authorization_token)
    file_name = local_file.original_filename.split(' ').join('_')
    content_type = local_file.content_type
    sha1 = Digest::SHA1.hexdigest(File.read(local_file.tempfile))
    uri = URI(upload_url)
    req = Net::HTTP::Post.new(uri)
    req.add_field("Authorization","#{upload_authorization_token}")
    req.add_field("X-Bz-File-Name","#{file_name}")
    req.add_field("Content-Type","#{content_type}")
    req.add_field("X-Bz-Content-Sha1","#{sha1}")
    req.add_field("Content-Length",File.size(local_file.tempfile))
    req.body = File.read(local_file.tempfile)
    http = Net::HTTP.new(req.uri.host, req.uri.port)
    http.use_ssl = (req.uri.scheme == 'https')
    res = http.start {|http| http.request(req)}
    case res
    when Net::HTTPSuccess then
        json = res.body
    when Net::HTTPRedirection then
        fetch(res['location'], limit - 1)
    else
        res.error!
    end
    JSON.parse(json)
  end
end
