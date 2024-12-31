//
//  AppConstants.swift
//  iTask
//
//  Created by Intelli on 2019-08-29.
//  Copyright © 2019 Intelli. All rights reserved.
//

import UIKit

struct StoryBoardConstant
{
    static let MAIN_STORYBOARD : UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
}

struct ErrorMsg
{
    static let keyTurnOnAppCellularData = "You can turn on cellular data for this app in Settings."
}


let constTypeiOS = 1
let currentDeviceType = (UIDevice.current.userInterfaceIdiom == .pad) ? 2 : 1

struct API
{
    //static let baseURL = "http://intelligrp.com/itask/public/api/"
    //static let baseURL = "http://hamiltondinner.intelligrp.com/api/"
    static let baseURL = "https://hamiltondinnerapp.intellidt.com/api/"

    //static let baseURL = "http://ilog.intelligrp.com/api/"
    //static let baseURL = "http://itask.canadasentinel.ca/api/" //last this one
    //static let baseURL = "http://192.168.1.51/api/"
    static let siteURL = "http://itask.canadasentinel.ca/"
    static let DefaultProfilePicURL = "images/add_profile.png"
    static let login_api = "login"
    static let register_api = "user-registration"
    static let verify_code_api = "verify-code"
    static let resend_code_api = "resend-code"
    static let forgot_password_api = "forgot-password"
    static let verify_otp_api = "verify-otp"
    static let resend_otp_api = "resend-otp"
    static let change_password_api = "change-password"
    static let add_project_api = "create-project"
    static let list_clients_api = "all-client-list"
    static let list_projects_api = "all-project-list"
    static let list_project_members_api = "project-task-member-list"
    static let add_log_api = "add-log"
    static let edit_log_api = "edit-log"
    static let delete_log_api = "delete-log"
    static let list_logs_api = "log-by-date"
    static let tasks_list_of_prj_api = "tasks-by-project-id"
    static let tasks_list_by_priority_api = "tasks-by-flag"
    static let tasks_list_of_inbox_api = "inbox-tasks"
    static let update_reminder_api = "update-reminder"
    static let update_due_date_api = "update-duedate-time"
    static let document_list_api = "document-list-by-project-id"
    static let remove_document_api = "delete-document"
    static let add_document_api = "upload-document"
    static let comment_list_api = "comments-by-project-id"
    static let add_comment_api = "add-comment"
    static let edit_comment_api = "edit-comment"
    static let delete_comment_api = "delete-comment"
    static let update_device_token_api = "update-device-token"
    static let dashboard_listing_api = "project-tag-list"
    static let list_notification_api = "notification-list"
    static let view_project_task_api = "project-task-detail"
    static let edit_profile_api = "update-user-details"
    static let get_user_details_api = "user-details"
    static let update_notification_settings_api  = "update-notification-setting"
    static let delete_task_api = "delete-project-task"
    static let update_timezone_api = "update-timezone"
    static let update_project_api = "update-project"
    static let mark_notification_api = "mark-as-read"
    static let update_default_reminder_api = "update-default-reminder"
    static let update_remind_via_api = "update-remind-via"
    static let update_task_api = "update-task"
    static let complete_uncomplete_task_api = "complete-uncomplete-task"
    static let send_to_review_api = "send-to-review"
    static let review_project_list_api = "review-project-list"
    static let search_list_api = "search-list"
    static let interacted_members_list_api = "associated-member-list"
    static let edit_task_members_api = "assign-member-task"
    static let mark_project_as_complete_api = "complete-project"
    static let edit_priority_api = "update-priority"
    static let tasks_list_by_tags_api = "project-task-by-tag"
    static let delete_account_api = "delete-account"
    static let get_notification_count_api = "notification-count"
    static let move_task_api = "move-task"
    static let room_list_api = "rooms-list"
    static let order_list_api = "order-list"
    static let item_list_api = "item-list"
    static let update_item_list_api = "update-order"
    static let general_form_submit_api = "general-form-submit"
    static let send_email_api = "send-email"
    
}

struct MoveTaskKey
{
    static let keyParentTaskId = "pt_id"
    static let keyParentId = "parent_id"
    static let keySelectedOption = "selected_value"
    static let keyOrder = "order"
}

struct SetUserTokenKey
{
    static let keyDeviceToken = "device_token"
    static let keyOldDeviceToken = "old_device_token"
}

struct ProjectListKey
{
    static let keyType = "type"
}

struct ViewProjectTaskKey
{
    static let keyProjectTaskId = "ptId"
}

struct DeleteTaskKey
{
    static let keyTaskId = "projectTaskId"
}

struct MarkNotificationKey
{
    static let keyNotificationId = "notification_id"
}

struct UpdateReminderOptionKey
{
    static let keyReminderOption = "defaultReminder"
}

struct UpdateRemindViaKey
{
    static let keyType = "type"
    static let keyValue = "value"
}

struct SearchListKey
{
    static let keyType = "type"
    static let keySearchText = "search_data"
}

struct UserDefaultKey
{
    static let keyAPNsDeviceToken = "APNsDeviceToken"
    static let keyUniqueDeviceId = "UniqueDeviceId"
    static let keyRoomId = "RoomId"
    static let keyRoomName = "RoomName"
    static let keyLoggedBy = "LoggedBy"
    static let keyAPIToken = "DinningAppAPIToken"
    static let keyUserTimeZone = "UserTimeZone"
    static let keyPrintPermissionStatus = "PrintPermissionStatus"
}

struct CompleteUncompleteTaskParam
{
    static let keyTaskId = "task_id"
    static let keyStatus = "status"
    static let keyStatusCompleted = "completed"
    static let keyStatusUnCompleted = "uncompleted"
}

struct AddDocumentParam
{
    static let keyProjectTaskId = "ptId"
}

struct AddCommentParam
{
    static let keyProjectTaskId = "ptId"
    static let keyComment = "comments"
    static let keyParentId = "commentParentId"
}

struct EditCommentParam
{
    static let keyCommentId = "commentId"
    static let keyComment = "comment"
}

struct DeleteCommentParam
{
    static let keyCommentId = "commentId"    
}

struct DocumentListParam
{
    static let keyProjectTaskId = "ptId"
}

struct CommentListParam
{
    static let keyProjectTaskId = "ptId"
}

struct RemoveDocumentParam
{
    static let keyDocumentId = "documentId"
}

struct TasksListByPrjParam
{
    static let keyProjectId = "ptId"
    static let keyIsCompleted = "is_completed"
    static let keyIsProjectCompleted = "is_completed_project"
    static let keyIsProjectReview = "is_display_review"
}

struct TasksListByPriorityParam
{
    static let keyPriority = "priority"
    static let keyIsCompleted = "is_completed"
    static let keyIsProjectCompleted = "is_completed_project"
    static let keyIsProjectReview = "is_display_review"
}

struct TasksListByTagsParam
{
    static let keyTagId = "tag_id"
    static let keyIsCompleted = "is_completed"
    static let keyIsProjectCompleted = "is_completed_project"
    static let keyIsProjectReview = "is_display_review"
}

struct UpdateReminderParam
{
    static let keyProjectTaskId = "ptId"
    static let keyReminder = "reminder"
}

struct UpdateDueDateParam
{
    static let keyProjectTaskId = "ptId"
    static let keyDueDate = "dueDate"
    static let keyDueDateTime = "dueDateTime"
}

struct UpdateTimeZoneParam
{
    static let keyTimeZone = "timezone"
}

struct EditTaskMemberParam
{
    static let keyTaskId = "task_id"
    static let keyMembers = "emails"
}

struct EditPriorityParam
{
    static let keyProjectTaskId = "ptId"
    static let keyPriority = "priority"
}

struct LoginParam
{
    static let keyEmailId = "email"
    static let keyPassword = "password"
    static let keyType = "type"
    static let keyDeviceType = "deviceType"
    static let keyTimeZone = "timezone"
}

struct ForgotPasswordParam
{
    static let keyEmailId = "email"
}

struct VerifyOTPParam
{
    static let keyEmailId = "email"
    static let keyOTPCode = "otp"
}

struct ResendOTPParam
{
    static let keyEmailId = "email"
}

struct ChangePasswordParam
{
    static let keyEmailId = "email"
    static let keyPassword = "password"
    static let keyTimeZone = "timezone"
}

struct RegisterParam
{
    static let keyName = "name"
    static let keyEmailId = "email"
    static let keyPassword = "password"
    static let keyType = "type"
    static let keyDeviceType = "deviceType"
    static let keyIsAvatarDeleted = "isAvatarDeleted"
}

struct VerifyCodeParam
{
    static let keyEmailId = "email"
    static let keyVerificationCode = "verificationCode"
    static let keyTimeZone = "timezone"
}

struct ResendCodeParam
{
    static let keyEmailId = "email"
}

struct GetMembersListParam
{
    static let keyProjectTaskId = "ptId"
}

struct ListMembersKeys
{
    static let keyMemberName = "name"
    static let keyMemberEmail = "email"
}

struct NotificationKeys
{
    static let keyNotificaitonId = "id"
    static let keyUserPicUrl = "sent_by_avatar"
    static let keyNotificationTitle = "notification_text"
    static let keyNotificationType = "notification_type"
    static let keyNotificationIsRead = "is_read"
    static let keyNotificationTime = "sent_time"
    static let keyNotificationDetails = "data_to_display"
    static let keyProjectTaskId = "project_id"
    static let keyProjectTaskName = "project_name"
    static let keyType = "type"
    static let keyProjectStatus = "project_status"
}

struct NotificationSettingsParam
{
    static let keyKeyValue = "settingType"
    static let keyNotificationOption = "notificationType"
    static let keyOptionValue = "value"
}

struct NotificationOptions
{
    static let keyEmail = "email"
    static let keyPush = "pushNotification"
}

struct SendToReviewParam
{
    static let keyProjectId = "project_id"
}

struct MarkProjectAsCompleteParam
{
    static let keyProjectId = "project_id"
}

struct MainResponseCodeConstant
{
    static let keyStatusCode = "StatusCode"
    static let keyResult = "Result"
    static let keyMessage = "Message"
    static let keyResponseCode = "ResponseCode"
    static let keyResponseText = "ResponseText"
    static let keyResponseCodeZero = 0
    static let keyResponseCodeOne = 1
    static let keyResponseCodeTwo = 2
    static let keyResponseCodeThree = 3
    static let keyResponseCodeFour = 4
    static let keyResponseCodeFive = 5
    static let keyResponseCodeSix = 6
    static let keyResponseCodeSeven = 7
    static let keyResponseCodeEight = 8
    static let keyResponseCodeEleven = 11
    static let keyTotalRecords = "total_records"
    static let keyAuthenticationToken = "authentication_token"
    static let keyUserId = "user_id"
    static let keyUserEmail = "user_email"
    static let keyClientsList = "clients"
    static let keySiderBarTagsList = "sidebar_tags"
    static let keyProjectsList = "projects"
    //static let keyTempProjectsList = "sub_projects"
    static let keyCompletedProjectsList = "completed_projects"
    static let keyMembersList = "members"
    static let keyRoomsList = "rooms"
    static let keyResidentsList = "tables"
    static let keyDocumentList = "documents"
    static let keyCommentList = "comments"
    static let keyAddComment = "add-comment"
    static let keyPermission = "permissions"
    static let keyNotificationList = "notifications"
    static let keyProjectTaskType = "type"
    static let keyProjectLevel = "level"
    static let keyIsCreator = "isCreator"
    static let keyIsAssignedToMe = "isAssigned"
    static let keyProjectTaskDetails = "data"
    static let keyName = "name"
    static let keyAvtar = "avatar"
    static let keyEmail = "email"
    static let keyNotificationSettings = "notification_settings"
    static let keyUserTimeZone = "timezone"
    static let keyAllTimeZonesList =  "timezones"
    static let keyDafultReminder = "default_reminder"
    static let keyEmailReminder = "remind_via_email"
    static let keyMobileNotiReminder = "remind_via_mobile_notification"
    static let keyDesktopNotiReminder = "remind_via_desktop_notification"
    static let keyProjectStatus = "status"
    static let keyRepeatedTask = "repeated_task"
    static let keyRepeatedProject = "repeated_project"
    static let keySearchResultList = "data"
    static let keyUserName = "user_name"
    static let keyRepeat = "repeat"
    static let keyParentProjectStatus = "parent_status"
    static let keyParentProjectId = "parent_project_id"
    static let keyCount = "count"
    static let keyData = "data"
    static let keyUserRole = "role"
    static let keyTotalHours = "total_hours"
    static let keyStartDt = "start_date"
    static let keyBrk = "breakfast"
    static let keyLunch = "lunch"
    static let keyDinner = "dinner"
    static let keyItems = "items"
    static let keySplInst = "special_instructions"
    static let keyIsRememberSplInst = "is_remember_comment"
    static let keyLastMenuDate = "last_menu_date"
}

struct MainResponseListingConstant
{
    static let keyAuthorListing = "author_data"
    static let keyCategoryListing = "category_list"
}

struct ProjectLocalKeys
{
    static let ProjectId = "ProjectId"
    static let ProjectName = "ProjectName"
    static let ProjectStatus = "ProjectStatus"
    static let IsFlagged = "IsFlagged"
    static let DueDateAndTime = "DueDateAndTime"
    static let EstimatedDuration = "EstimatedDuration"
    static let EstimatedDurationIn = "EstimatedDurationIn"
    static let ProjectType = "ProjectType"
    static let ProjectNotes = "ProjectNotes"
    static let CreatedByUserId = "CreatedByUserId"
    static let CreatedOnDateTime = "CreatedOnDateTime"
    static let IsUploadedOnServer = "IsUploadedOnServer"
}

struct AddProjectKeys
{
    static let keyClientId = "client_id"
    static let keyProjectName = "project_id"
    static let keyProjectDescription = "description"
}

struct AddLogKeys
{
    static let keyLogId = "log_id"
    static let keyProjectId = "project_id"
    static let keyClientId = "client_id"
    static let keyTotalHours = "total_hours"
    static let keyLogDate = "log_date"
    static let keyLogDescription = "description"
}


struct ProjectKeys
{
    static let ProjectId = "id"
    static let ProjectName = "project_id"
    static let ProjectDescription = "description"
}

struct LogKeys
{
    static let LogId = "id"
    static let ProjectId = "project_id"
    static let ProjectName = "project_code"
    static let ClientId = "client_id"
    static let ClientName = "client_code"
    static let LogDate = "log_date"
    static let LogHours = "total_hours"
    static let LogDescription = "description"
}

struct TableKeys
{
    static let TableId = "id"
    static let TableName = "name"
}

struct RoomKeys
{
    static let RoomId = "id"
    static let RoomName = "name"
    static let Occupancy = "occupancy"
    static let ResidentName = "resident_name"
}

struct CategoryItemsKeys
{
    static let CatId = "cat_id"
    static let CatName = "cat_name"
    static let ChineseName = "chinese_name"
    static let CatItems = "items"
    static let SubCatItems = "sub_cat"
}

struct ItemsKeys
{
    static let ItemId = "item_id"
    static let ItemName = "item_name"
    static let ItemQuantity = "qty"
    static let Comment = "comment"
    static let OrderId = "order_id"
    static let ItemImage = "item_image"
    static let ItemType = "type"
    static let ChineseName = "chinese_name"
    static let ItemOptions = "options"
    static let Preferences = "preference"
}

struct ItemType
{
    static let Item = "item"
    static let SubCat = "sub_cat"
    static let SubCatItem = "sub_cat_item"
}

struct ProjectTaskKeys
{
    static let ProjectTaskId = "id"
    static let ProjectTaskName = "name"
    static let DueDate = "dueDate"
    static let DueDateTime = "dueDateTime"
    static let Repeat = "repeat"
    static let Reminder = "reminder"
    static let Flag = "flag"
    static let Color = "color"
    static let Note = "note"
    static let ParentId = "parentId"
    static let Level = "parentLevel"
    static let ParentProjectStatus = "parentProjectStatus"
    static let Status = "status"
    static let TagsName = "tags"
    static let ParentProjectName = "parentProjectName"
    static let Members = "members"
    static let MemberNames = "member_names"
    static let IsProjectTaskCreator = "is_creator_of_project"
    static let IsTaskAssignedToMe = "is_assigned"
    static let ImmediateParentId = "currentParentId"
}

struct TasksSubProjectsListKeys
{
    static let ProjectTaskId = "id"
    static let ProjectTaskName = "name"
    static let ProjectTaskFlag = "flag"
    static let DueDate = "due_date"
    static let TagsName = "tags"
    static let ProjectName = "parent_project_name"
    static let ProjectColor = "parent_project_color"
    static let ProjectStatus = "parent_project_status"
    static let PrarentProjectId = "parent_id"
    static let CommentCount = "total_comments"
    static let DocumentCount = "total_documents"
    static let ProjectTaskType = "type"
    static let IsProjectTaskCreator = "is_creator_of_project"
    static let IsTaskAssignedToMe = "is_assigned"
    static let OriginalDueDate = "original_due_date"
    static let OriginalDueDateTime = "original_due_date_time"
    static let Reminder = "reminder"
    static let Repeat = "repeat"
    static let ProjectTaskLevel = "level"
    static let IsOverdue = "is_overdue"
    static let ProjectTaskStatus = "status"
    static let CreatorName = "creator_name"
    static let MemberNames = "member_names"
    static let MemberEmails = "member_emails"
    static let Childs = "childs"
    static let BaseParentId = "base_parent_id"
    static let BaseParentLevel = "base_parent_level"
    static let MaxChildLevel = "maxChildLevel"
    static let Order = "order"
}

struct ProjectMembersKeys
{
    static let ProjectId = "ProjectId"
    static let MemberUserId = "MemberUserId"
    static let MemberEmailId = "MemberEmailId"
    static let HasCreatedProject = "HasCreatedProject"
    static let IsUploadedOnServer = "IsUploadedOnServer"
}

struct NotificationOptionKeys
{
    static let OptionTitle = "title"
    static let EmailValue = "email"
    static let PushValue = "push_notification"
    static let KeyValue = "key_val"
}

struct TagKeys
{
    static let TagId = "id"
    static let TagName = "name"
}

struct InteractedMemberKeys
{
    static let Id = "id"
    static let Name = "name"
    static let Email = "email"
}

struct DocumentKeys
{
     static let DocId = "id"
     static let DocName = "name"
     static let DocSize = "size"
     static let DocType = "type"
     static let DocURL = "baseUrl"
     static let DocThumb = "thumbUrl"
     static let DocUploadedBy = "uploadedBy"
     static let DocUploadedByName = "uploadedByName"
     static let DpcUploadedTime = "uploadedTime"
}

struct AddEditTagKeys
{
    static let keyProjectTaskId = "ptId"
    static let keyTagId = "tagId"
    static let keyTagName = "tagName"
}

struct TaskKeys
{
    static let TaskId = "TaskId"
    static let TaskName = "TaskName"
    static let ProjectId = "ProjectId"
    static let IsFlagged = "IsFlagged"
    static let DueDateAndTime = "DueDateAndTime"
    static let EstimatedDuration = "EstimatedDuration"
    static let EstimatedDurationIn = "EstimatedDurationIn"
    static let TaskNotes = "TaskNotes"
    static let CreatedByUserId = "CreatedByUserId"
    static let CreatedOnDateTime = "CreatedOnDateTime"
    static let AssignedToUserId = "AssignedToUserId"
    static let AssignedOnDateTime = "AssignedOnDateTime"
    static let IsTaskCompleted = "IsTaskCompleted"
    static let CompletedOnDateTime = "CompletedOnDateTime"
    static let IsUploadedOnServer = "IsUploadedOnServer"
}

struct CommentsKeys
{
    static let CommentId = "id"
    static let CommentText = "comment"
    static let CommentParentId = "parentID"
    static let CommentLevel = "level"
    static let DocumentName = "documentName"
    static let DocumentSize = "documentSize"
    static let DocumentType = "documentType"
    static let DocumentURL = "documentURL"
    static let DocumentThumbURL = "documentThumbUrl"
    static let CommentBy = "commentedBy"
    static let CommentDateTime = "commentedTime"
    static let CommentByUserId = "commentedByUserId"
    static let ProjectTaskType = "type"
    static let ProjectTaskName = "ptName"
    static let ProjectTaskId = "ptID"
}

struct NotificationNamesConstant
{
    static let keyCalMinDateUpdated = "CalMinDateUpdated"
    static let keyCommentCountUpdated = "CommentCountUpdated"
    static let keyDocumentCountUpdated = "DocumentCountUpdated"
    static let keyRepeatCustomSelection = "RepeatCustomSelection"
    static let keyAddProjectTagSelectionDone = "AddProjectTagSelectionDone"
    static let keyAddProjectCntSelectionDone = "AddProjectCntSelectionDone"
    static let keyAddPhoneCntSelectionDone = "AddPhoneCntSelectionDone"
    static let keyAddProjectDone = "AddProjectDone"
    static let keyUpdateCommentList = "UpdateCommentList"
    static let keyUpdateDocumentList = "UpdateDocumentList"
    static let keyUpdateNotificationList = "UpdateNotificationList"
    static let keyAccountDetailsUpdated = "AccountDetailsUpdated"
    static let keyProjectTaskDeleted = "ProjectTaskDeleted"
    static let keyTaskCountUpdated = "TaskCountUpdated"
    static let keyProjectDeleted = "ProjectDeleted"
    static let keyUpdateTaskListForProjectDeleted = "UpdateTaskListForProjectDeleted"
    static let keyProjectDetailsEdited = "ProjectDetailsEdited"
    static let keyProjectParentEdited = "ProjectParentEdited"
    static let keyProjectNameEdited = "ProjectNameEdited"
    static let keyProjectMembersEdited = "ProjectMembersEdited"
    static let keyOtherMembersUpdated = "OtherMembersUpdated"
    static let keyRemovedFromProject = "RemovedFromProject"
    static let keyRemovedFromTask = "RemovedFromTask"
    static let keyTaskDetailsEdited = "TaskDetailsEdited"
    static let keyAssignedTask = "AssignedIntoTask"
    static let keySelfTaskUnCompleted = "SelfTaskUnCompleted"
    static let keyTaskUnCompleted = "TaskUnCompleted"
    static let keyTaskCompleted = "TaskCompleted"
    static let keyProjectStatusChanged = "ProjectStatusChanged"
    static let keyAddTaskDone = "AddTaskDone"
    static let keyEditTaskMembersDone = "EditTaskMembersDone"
    static let keyUpdateRepeatingProjectDetails = "UpdateRepeatingProjectDetails"
    static let keyEditTagsDone = "EditTagsDone"
    static let keyRefreshNotificationCount = "RefreshNotificationCount"
    static let keyDefaultReminderSet = "DefaultReminderSet"
    static let keyProjectTaskDetailsEdited = "ProjectTaskDetailsEdited"
    static let keyReorderPerformed = "ReorderPerformed"
    static let keyItemOrderDone = "ItemOrderDone"
    static let keyAppEnteredBg = "AppEnteredBg"
    static let keyRefreshFormList = "RefreshFormList"
    static let keyAttachmentUpdated = "AttachmentUpdated"
}


struct PermissionNames
{
     static let keyAddComment = "add_comment"
     static let keyAddDocument = "add_document"
     static let keyAddMember = "add_member"
     static let keyAddSubProject = "add_sub_project"
     static let keyAddTask = "add_task"
     static let keyEdit = "edit"
     static let keyDelete = "delete"
     static let keyDeleteComment = "delete_comment"
     static let keyDeleteDocument = "delete_document"
     static let keyEditMember = "edit_member"
     static let keyView = "view"
     static let keyViewComment = "view_comments"
     static let keyViewDocument = "view_document"
}

struct PermissionFor
{
    static let keyProject = "project"
    static let keySubProject = "sub_project"
    static let keyTask = "task"
}

struct PermissionTo
{
    static let keyCreator = "creator"
    static let keyProjectMembers = "project_member"
    static let keyTaskMembers = "task_member"
    static let keyAllMembers = "all"
}

struct PushNotificationKeysConstant
{
    static let keyId = "project_id"
    static let keyTaskId = "task_id"
    static let keyName = "project_name"
    static let keyType = "type"
    static let keySubType = "subtype"
    static let keySubTypeProject = "project"
    static let keySubTypeTask = "task"
    static let keyTypeComment = "comment"
    static let keyTypeEditComment = "edit_comment"
    static let keyTypeDeleteComment = "delete_comment"
    static let keyTypeAttachment = "attachment"
    static let keyTypeDeleteAttachment = "delete_attachment"
    static let keyTypeAssign = "assign"
    static let keyTypeReminder = "reminder"
    static let keyTypeDelete = "delete"
    static let keyTypeRemove = "removed"
    static let keyTypeRemovedTask = "removed_task"
    static let keyTypeRemovedBy = "removed_by"
    static let keyTypeUpdateMember = "update_member"
    static let keyParentId = "parent_id"
    static let keyMemberRemoved = "member_removed"
    static let keyMembers = "members"
    static let keyTaskDetails = "task_details"
    static let keyTypeTaskCompleted = "completed"
    static let keyTypeTaskUnCompleted = "uncompleted"
    static let keyStatus = "status"
    static let keyIsRepeated  = "is_repeated"
    static let keyProjectStatus = "project_status"
    static let keyLevel = "level"
    static let keyParentStatus = "parent_status"
    static let keyDueDate = "due_date"
    static let keyOwnerName = "owner_name"
    static let keyCmtCount = "CmtCount"
    static let keyAttachmentCount = "attachment_count"
    static let keyTypeUpdateTask = "update_task"
    static let keyTypeUpdateProject = "update_project"
    static let keyAllParentIds = "all_parent_ids"
    static let keyAllChildIds = "all_child_ids"
    static let keyNoOfTasks = "no_of_tasks"
    static let keyTypeReorder = "reorder"
    static let keyFirstParentProjectId = "first_parent_project_id"
    static let keyIsParentChanged  = "is_parent_changed"
    static let keyOldParentId  = "old_parent_id"
    static let keyNewParentId  = "new_parent_id"
    static let keyOldParentCount  = "old_parent_count"
    static let keyNewParentCount  = "new_parent_count"
    static let keyNewAllParentIds = "new_all_parent_ids"
    static let keyFormId = "form_id"
    static let keyFormPDFURL = "newLink"
}

struct SearchType
{
    static let keyTask = "task"
    static let keyProject = "project"
    static let keyTags = "tags"
    static let keyComment = "comment"
}
