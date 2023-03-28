import 'package:flutter_jsonschema_builder/src/helpers/helpers.dart';

/// check if the string [input] is a URL
///
/// `options` is a `Map` which defaults to
/// `{ 'protocols': ['http','https','ftp'], 'require_tld': true,
/// 'require_protocol': false, 'allow_underscores': false,
/// 'host_whitelist': [], 'host_blacklist': [] }`.
bool isURL(String? input, [Map<String, dynamic>? options]) {
  var str = input;
  if (str == null ||
      str.isEmpty ||
      str.length > 2083 ||
      str.startsWith('mailto:')) {
    return false;
  }

  Map<String, dynamic> defaultUrlOptions = {
    'protocols': ['http', 'https', 'ftp'],
    'require_tld': true,
    'require_protocol': false,
    'allow_underscores': false,
    'host_whitelist': [],
    'host_blacklist': [],
  };

  options = merge(options, defaultUrlOptions);

  // check protocol
  var split = str.split('://');
  if (split.length > 1) {
    final protocol = shift(split);
    final protocols = options['protocols'] as List<String>;
    if (!protocols.contains(protocol)) {
      return false;
    }
  } else if (options['require_protocols'] == true) {
    return false;
  }
  str = split.join('://');

  // check hash
  split = str.split('#');
  str = shift(split);
  final hash = split.join('#');
  if (hash.isNotEmpty && RegExp(r'\s').hasMatch(hash)) {
    return false;
  }

  // check query params
  split = str?.split('?') ?? [];
  str = shift(split);
  final query = split.join('?');
  if (query.isNotEmpty && RegExp(r'\s').hasMatch(query)) {
    return false;
  }

  // check path
  split = str?.split('/') ?? [];
  str = shift(split);
  final path = split.join('/');
  if (path.isNotEmpty && RegExp(r'\s').hasMatch(path)) {
    return false;
  }

  // check auth type urls
  split = str?.split('@') ?? [];
  if (split.length > 1) {
    final auth = shift(split);
    if (auth != null && auth.contains(':')) {
      final parts = auth.split(':');
      final user = shift(parts);
      if (user != null && !RegExp(r'^\S+$').hasMatch(user)) {
        return false;
      }
      final pass = parts.join(':');
      if (!RegExp(r'^\S*$').hasMatch(pass)) {
        return false;
      }
    }
  }

  // check hostname
  final hostname = split.join('@');
  split = hostname.split(':');
  final host = shift(split);
  if (split.isNotEmpty) {
    final portStr = split.join(':');
    final port = int.tryParse(portStr, radix: 10);

    if (!RegExp(r'^[0-9]+$').hasMatch(portStr) ||
        port == null ||
        port <= 0 ||
        port > 65535) {
      return false;
    }
  }

  if (options['host_whitelist']?.isNotEmpty == true &&
      !options['host_whitelist'].contains(host)) {
    return false;
  }

  if (options['host_blacklist']?.isNotEmpty == true &&
      options['host_blacklist'].contains(host)) {
    return false;
  }

  return true;
}
