
#!/bin/sh

# replace /__BASEPATH__ with the runtime-configured entrypoint
if [ "$NEXT_PUBLIC_BASEPATH" = "" ]; then
  # root entrypoint is handled differently from non-root, in particular
  #  - basePath="" rather than "/"
  #  - an extra redirect is added /x/ => /x -- but with root that would be // => / which is invalid
  cp .next/routes-manifest.json .next/routes-manifest.json.in
  jq -rc '.basePath = ""
    | .redirects = [
        .redirects
        | .[]
        | select((.source == "/__BASEPATH__/" and .destination == "/__BASEPATH__") | not)
      ]' .next/routes-manifest.json.in > .next/routes-manifest.json
fi
# first we look for /__BASEPATH__/ -- this should become / in the case of empty entrypoint
#  then we look for /__BASEPATH__ -- this should become "" in the case of empty entrypoint
find .next server.js \
  -type f \
  -exec sed -i \
    -e "s#/__BASEPATH__/#${NEXT_PUBLIC_BASEPATH}/#g" \
    -e "s#/__BASEPATH__#${NEXT_PUBLIC_BASEPATH}#g" \
    {} +
