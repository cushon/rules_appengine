#!/bin/bash

set -e

RUNFILES="$TEST_SRCDIR"
if [ -d "${TEST_SRCDIR}/io_bazel_rules_appengine" ]; then
  RUNFILES="${TEST_SRCDIR}/io_bazel_rules_appengine"
fi
TEST_WAR="${RUNFILES}/test/java/test-war.war"
JAR="$1/bin/jar"

function assert_war_contains() {
  local needle="$1"
  "${JAR}" -tf "$TEST_WAR" | grep -sq "$needle" && return 0
  echo "Contents of $TEST_WAR:"
  "${JAR}" -tf "$TEST_WAR"
  echo "Expected '$needle' in $TEST_WAR"
  return 1
}

assert_war_contains "./WEB-INF/lib/app_deploy.jar"
assert_war_contains "./WEB-INF/lib/appengine-api.jar"
assert_war_contains "./WEB-INF/appengine-web.xml"
assert_war_contains "./WEB-INF/web.xml"
assert_war_contains "./data/welcome.jsp"
assert_war_contains "./data/gen-data.out"
