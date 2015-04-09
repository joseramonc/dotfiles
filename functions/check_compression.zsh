# check if a site has gzip enabled
function check_compression {
  curl -I -H 'Accept-Encoding: gzip,deflate' $1 |grep "Content-Encoding"
}
