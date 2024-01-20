class Event<T> {
  T _content;

  Event(this._content);

  var _hasBeenHandled = false;

// Allow external read but not write

  /// Returns the content and prevents its use again.
  T ?getContentIfNotHandled() {
    if (_hasBeenHandled) {
      return null;
    } else {
      _hasBeenHandled = true;
      return _content;
    }
  }

  /// Returns the content, even if it's already been handled.
  T peekContent() => _content;
}
