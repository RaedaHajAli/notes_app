import '../../app/extensions.dart';

import '../../app/constants.dart';
import '../../data/responses/responses.dart';
import '../models/models.dart';

extension UserResponseExtension on UserResponse? {
  User toDomain() {
    return User(
        id: this?.id.orZero() ?? Constants.zero,
        username: this?.username.orEmpty() ?? Constants.empty,
        email: this?.email.orEmpty() ?? Constants.empty);
  }
}

extension AuthenticationExtension on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(data: this?.data.toDomain());
  }
}

extension OperationStatusResponseExtension on OperationStatusResponse? {
  OperationStatus toDomain() {
    return OperationStatus(
        status: this?.status ?? Constants.zero,
        message: this?.message ?? Constants.empty);
  }
}

extension NoteResponseExtension on NoteResponse? {
  Note toDomain() {
    return Note(
      id: this?.id ?? Constants.zero,
      title: this?.title ?? Constants.empty,
      content: this?.content ?? Constants.empty,
      image: this?.image ?? Constants.empty,
      userId: this?.userId ?? Constants.zero,
    );
  }
}

extension GetNotesResponseExtension on GetNotesResponse? {
  GetNotes toDomain() {
    List<Note> notes =
        (this?.notes?.map((noteResponse) => noteResponse.toDomain()) ??
                const Iterable.empty())
            .cast<Note>()
            .toList();

    return GetNotes(notes: notes);
  }
}
