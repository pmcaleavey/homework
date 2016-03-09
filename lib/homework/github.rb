module Homework
  class Github
    include HTTParty
    base_uri "https://api.github.com"

    def initialize
      @auth_token = "f8fc5b09763cfdb64e6a6cd3a25d2805d7f1d303"
      @headers = {
        "Authorization" => "token #{@auth_token}",
        "User-Agent"    => "HTTParty"
      }
    end

    def get_user(username)
      Github.get("/users/#{username}", headers: @headers)
    end

    def list_members_by_team_name(org, team_name)
      teams = list_teams(org)
      team = teams.find { |team| team["name"] == team_name }
      list_team_members(team["id"])
    end

    def list_teams(organization)
      Github.get("/orgs/#{organization}/teams", headers: @headers)
    end

    def list_team_members(team_id)
      Github.get("/teams/#{team_id}/members", headers: @headers)
    end

    def list_issues(owner, repo)
      Github.get("/repos/#{owner}/#{repo}/issues", headers: @headers)
    end

    #PATCH /repos/:owner/:repo/issues/:number
    def close_an_issue(owner, repo, number)
      Github.patch("/repos/#{owner}/#{repo}/issues/#{number}", headers: @headers,
        body: {state: "closed" }.to_json)
    end

    #POST /repos/:owner/:repo/issues/:number/comments
    def comment_on_issue(owner, repo, number)
      Github.post("/repos/#{owner}/#{repo}/issues/#{number}/comments", headers: @headers,
        body: {body: "Comments on Test 2"}.to_json)
    end
  end
end
