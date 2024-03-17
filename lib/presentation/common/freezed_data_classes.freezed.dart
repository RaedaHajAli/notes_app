// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'freezed_data_classes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LoginObject {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginObjectCopyWith<LoginObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginObjectCopyWith<$Res> {
  factory $LoginObjectCopyWith(
          LoginObject value, $Res Function(LoginObject) then) =
      _$LoginObjectCopyWithImpl<$Res, LoginObject>;
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class _$LoginObjectCopyWithImpl<$Res, $Val extends LoginObject>
    implements $LoginObjectCopyWith<$Res> {
  _$LoginObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginObjectImplCopyWith<$Res>
    implements $LoginObjectCopyWith<$Res> {
  factory _$$LoginObjectImplCopyWith(
          _$LoginObjectImpl value, $Res Function(_$LoginObjectImpl) then) =
      __$$LoginObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class __$$LoginObjectImplCopyWithImpl<$Res>
    extends _$LoginObjectCopyWithImpl<$Res, _$LoginObjectImpl>
    implements _$$LoginObjectImplCopyWith<$Res> {
  __$$LoginObjectImplCopyWithImpl(
      _$LoginObjectImpl _value, $Res Function(_$LoginObjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_$LoginObjectImpl(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoginObjectImpl implements _LoginObject {
  _$LoginObjectImpl(this.email, this.password);

  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'LoginObject(email: $email, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginObjectImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginObjectImplCopyWith<_$LoginObjectImpl> get copyWith =>
      __$$LoginObjectImplCopyWithImpl<_$LoginObjectImpl>(this, _$identity);
}

abstract class _LoginObject implements LoginObject {
  factory _LoginObject(final String email, final String password) =
      _$LoginObjectImpl;

  @override
  String get email;
  @override
  String get password;
  @override
  @JsonKey(ignore: true)
  _$$LoginObjectImplCopyWith<_$LoginObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SignupObject {
  String get userName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SignupObjectCopyWith<SignupObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignupObjectCopyWith<$Res> {
  factory $SignupObjectCopyWith(
          SignupObject value, $Res Function(SignupObject) then) =
      _$SignupObjectCopyWithImpl<$Res, SignupObject>;
  @useResult
  $Res call({String userName, String email, String password});
}

/// @nodoc
class _$SignupObjectCopyWithImpl<$Res, $Val extends SignupObject>
    implements $SignupObjectCopyWith<$Res> {
  _$SignupObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignupObjectImplCopyWith<$Res>
    implements $SignupObjectCopyWith<$Res> {
  factory _$$SignupObjectImplCopyWith(
          _$SignupObjectImpl value, $Res Function(_$SignupObjectImpl) then) =
      __$$SignupObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userName, String email, String password});
}

/// @nodoc
class __$$SignupObjectImplCopyWithImpl<$Res>
    extends _$SignupObjectCopyWithImpl<$Res, _$SignupObjectImpl>
    implements _$$SignupObjectImplCopyWith<$Res> {
  __$$SignupObjectImplCopyWithImpl(
      _$SignupObjectImpl _value, $Res Function(_$SignupObjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_$SignupObjectImpl(
      null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SignupObjectImpl implements _SignupObject {
  _$SignupObjectImpl(this.userName, this.email, this.password);

  @override
  final String userName;
  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'SignupObject(userName: $userName, email: $email, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignupObjectImpl &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userName, email, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SignupObjectImplCopyWith<_$SignupObjectImpl> get copyWith =>
      __$$SignupObjectImplCopyWithImpl<_$SignupObjectImpl>(this, _$identity);
}

abstract class _SignupObject implements SignupObject {
  factory _SignupObject(
          final String userName, final String email, final String password) =
      _$SignupObjectImpl;

  @override
  String get userName;
  @override
  String get email;
  @override
  String get password;
  @override
  @JsonKey(ignore: true)
  _$$SignupObjectImplCopyWith<_$SignupObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AddNoteWithImageObject {
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  File get image => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AddNoteWithImageObjectCopyWith<AddNoteWithImageObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddNoteWithImageObjectCopyWith<$Res> {
  factory $AddNoteWithImageObjectCopyWith(AddNoteWithImageObject value,
          $Res Function(AddNoteWithImageObject) then) =
      _$AddNoteWithImageObjectCopyWithImpl<$Res, AddNoteWithImageObject>;
  @useResult
  $Res call({String title, String content, File image});
}

/// @nodoc
class _$AddNoteWithImageObjectCopyWithImpl<$Res,
        $Val extends AddNoteWithImageObject>
    implements $AddNoteWithImageObjectCopyWith<$Res> {
  _$AddNoteWithImageObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? content = null,
    Object? image = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddNoteWithImageObjectImplCopyWith<$Res>
    implements $AddNoteWithImageObjectCopyWith<$Res> {
  factory _$$AddNoteWithImageObjectImplCopyWith(
          _$AddNoteWithImageObjectImpl value,
          $Res Function(_$AddNoteWithImageObjectImpl) then) =
      __$$AddNoteWithImageObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String content, File image});
}

/// @nodoc
class __$$AddNoteWithImageObjectImplCopyWithImpl<$Res>
    extends _$AddNoteWithImageObjectCopyWithImpl<$Res,
        _$AddNoteWithImageObjectImpl>
    implements _$$AddNoteWithImageObjectImplCopyWith<$Res> {
  __$$AddNoteWithImageObjectImplCopyWithImpl(
      _$AddNoteWithImageObjectImpl _value,
      $Res Function(_$AddNoteWithImageObjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? content = null,
    Object? image = null,
  }) {
    return _then(_$AddNoteWithImageObjectImpl(
      null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File,
    ));
  }
}

/// @nodoc

class _$AddNoteWithImageObjectImpl implements _AddNoteWithImageObject {
  _$AddNoteWithImageObjectImpl(this.title, this.content, this.image);

  @override
  final String title;
  @override
  final String content;
  @override
  final File image;

  @override
  String toString() {
    return 'AddNoteWithImageObject(title: $title, content: $content, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddNoteWithImageObjectImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.image, image) || other.image == image));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, content, image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddNoteWithImageObjectImplCopyWith<_$AddNoteWithImageObjectImpl>
      get copyWith => __$$AddNoteWithImageObjectImplCopyWithImpl<
          _$AddNoteWithImageObjectImpl>(this, _$identity);
}

abstract class _AddNoteWithImageObject implements AddNoteWithImageObject {
  factory _AddNoteWithImageObject(
          final String title, final String content, final File image) =
      _$AddNoteWithImageObjectImpl;

  @override
  String get title;
  @override
  String get content;
  @override
  File get image;
  @override
  @JsonKey(ignore: true)
  _$$AddNoteWithImageObjectImplCopyWith<_$AddNoteWithImageObjectImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AddNoteWithoutImageObject {
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AddNoteWithoutImageObjectCopyWith<AddNoteWithoutImageObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddNoteWithoutImageObjectCopyWith<$Res> {
  factory $AddNoteWithoutImageObjectCopyWith(AddNoteWithoutImageObject value,
          $Res Function(AddNoteWithoutImageObject) then) =
      _$AddNoteWithoutImageObjectCopyWithImpl<$Res, AddNoteWithoutImageObject>;
  @useResult
  $Res call({String title, String content});
}

/// @nodoc
class _$AddNoteWithoutImageObjectCopyWithImpl<$Res,
        $Val extends AddNoteWithoutImageObject>
    implements $AddNoteWithoutImageObjectCopyWith<$Res> {
  _$AddNoteWithoutImageObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? content = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddNoteWithoutImageObjectImplCopyWith<$Res>
    implements $AddNoteWithoutImageObjectCopyWith<$Res> {
  factory _$$AddNoteWithoutImageObjectImplCopyWith(
          _$AddNoteWithoutImageObjectImpl value,
          $Res Function(_$AddNoteWithoutImageObjectImpl) then) =
      __$$AddNoteWithoutImageObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String content});
}

/// @nodoc
class __$$AddNoteWithoutImageObjectImplCopyWithImpl<$Res>
    extends _$AddNoteWithoutImageObjectCopyWithImpl<$Res,
        _$AddNoteWithoutImageObjectImpl>
    implements _$$AddNoteWithoutImageObjectImplCopyWith<$Res> {
  __$$AddNoteWithoutImageObjectImplCopyWithImpl(
      _$AddNoteWithoutImageObjectImpl _value,
      $Res Function(_$AddNoteWithoutImageObjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? content = null,
  }) {
    return _then(_$AddNoteWithoutImageObjectImpl(
      null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AddNoteWithoutImageObjectImpl implements _AddNoteWithoutImageObject {
  _$AddNoteWithoutImageObjectImpl(this.title, this.content);

  @override
  final String title;
  @override
  final String content;

  @override
  String toString() {
    return 'AddNoteWithoutImageObject(title: $title, content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddNoteWithoutImageObjectImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, content);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddNoteWithoutImageObjectImplCopyWith<_$AddNoteWithoutImageObjectImpl>
      get copyWith => __$$AddNoteWithoutImageObjectImplCopyWithImpl<
          _$AddNoteWithoutImageObjectImpl>(this, _$identity);
}

abstract class _AddNoteWithoutImageObject implements AddNoteWithoutImageObject {
  factory _AddNoteWithoutImageObject(final String title, final String content) =
      _$AddNoteWithoutImageObjectImpl;

  @override
  String get title;
  @override
  String get content;
  @override
  @JsonKey(ignore: true)
  _$$AddNoteWithoutImageObjectImplCopyWith<_$AddNoteWithoutImageObjectImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$EditNoteObject {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  File get image => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EditNoteObjectCopyWith<EditNoteObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditNoteObjectCopyWith<$Res> {
  factory $EditNoteObjectCopyWith(
          EditNoteObject value, $Res Function(EditNoteObject) then) =
      _$EditNoteObjectCopyWithImpl<$Res, EditNoteObject>;
  @useResult
  $Res call({int id, String title, String content, File image});
}

/// @nodoc
class _$EditNoteObjectCopyWithImpl<$Res, $Val extends EditNoteObject>
    implements $EditNoteObjectCopyWith<$Res> {
  _$EditNoteObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? image = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EditNoteObjectImplCopyWith<$Res>
    implements $EditNoteObjectCopyWith<$Res> {
  factory _$$EditNoteObjectImplCopyWith(_$EditNoteObjectImpl value,
          $Res Function(_$EditNoteObjectImpl) then) =
      __$$EditNoteObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String title, String content, File image});
}

/// @nodoc
class __$$EditNoteObjectImplCopyWithImpl<$Res>
    extends _$EditNoteObjectCopyWithImpl<$Res, _$EditNoteObjectImpl>
    implements _$$EditNoteObjectImplCopyWith<$Res> {
  __$$EditNoteObjectImplCopyWithImpl(
      _$EditNoteObjectImpl _value, $Res Function(_$EditNoteObjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? image = null,
  }) {
    return _then(_$EditNoteObjectImpl(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File,
    ));
  }
}

/// @nodoc

class _$EditNoteObjectImpl implements _EditNoteObject {
  _$EditNoteObjectImpl(this.id, this.title, this.content, this.image);

  @override
  final int id;
  @override
  final String title;
  @override
  final String content;
  @override
  final File image;

  @override
  String toString() {
    return 'EditNoteObject(id: $id, title: $title, content: $content, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditNoteObjectImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.image, image) || other.image == image));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, content, image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EditNoteObjectImplCopyWith<_$EditNoteObjectImpl> get copyWith =>
      __$$EditNoteObjectImplCopyWithImpl<_$EditNoteObjectImpl>(
          this, _$identity);
}

abstract class _EditNoteObject implements EditNoteObject {
  factory _EditNoteObject(final int id, final String title,
      final String content, final File image) = _$EditNoteObjectImpl;

  @override
  int get id;
  @override
  String get title;
  @override
  String get content;
  @override
  File get image;
  @override
  @JsonKey(ignore: true)
  _$$EditNoteObjectImplCopyWith<_$EditNoteObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
