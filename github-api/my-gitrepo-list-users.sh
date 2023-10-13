#!/bin/bash
#set -x
REPO_OWNER=$1
REPO_NAME=$2
USERNAME=$username
TOKEN=$token
GITHUB_API_URL="https://api.github.com"
URL=$GITHUB_API_URL/repos/${REPO_OWNER}/${REPO_NAME}/collaborators

function get_github_api {
  curl -s -u "$USERNAME:$TOKEN" "$URL"
}

function list_repo_users {
  local users
  users="$(get_github_api | jq -r '.[] | select(.permissions.pull == true) | .login')"
   if [[ -z "$users" ]]; then
          echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
      else
          echo "Users with read access to ${REPO_OWNER}/${REPO_NAME}:"
          echo "$users"
      fi
}
#Calling main script
echo "Listing users with read access to ${REPO_OWNER}/${REPO_NAME}..."
list_repo_users