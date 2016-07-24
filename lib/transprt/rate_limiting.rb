module Transprt
  class RateLimiting
    # Performs HTTP queries while respecting the rate limit.

    # @param wait_for_quota [Boolean] whether to wait for quota reset
    #        and query again if the rate limit (300 requests/s) is exceeded.
    def initialize(wait_for_quota=true)
      @wait_for_quota = true
    end

    # @return The HTTP response or nil if we're hitting the rate limit and
    #         wait_for_quota is false (@see #initialize).
    def get(url)
      begin
        response = perform_get(url)
      rescue RestClient::TooManyRequests => e
        # API uses HTTP 429 to notify us,
        # @see https://github.com/OpendataCH/Transport/blob/master/lib/Transport/Application.php

        return nil unless wait_for_quota

        sleep_until_quota_reset(e.response)
        response = perform_get(url)
      end

      response
    end

    private

    attr_reader :wait_for_quota

    def perform_get(url)
      RestClient.get(url)
    end

    def sleep_until_quota_reset(response)
      # NOTE We rely on the local clock being synchronized
      # with the server clock.

      reset_at = response.headers['X-Rate-Limit-Reset'].to_i
      delta = reset_at - Time.now.to_i

      return if delta < 0
      sleep delta
    end
  end
end
