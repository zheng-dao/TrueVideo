import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/core/router/router.dart';
import 'package:truvideo_enterprise/core/widget.dart';
import 'package:truvideo_enterprise/hook/is_debug.dart';
import 'package:truvideo_enterprise/model/checklist/extra_note/extra_note.dart';
import 'package:truvideo_enterprise/model/checklist/item/item.dart';
import 'package:truvideo_enterprise/model/checklist/reply/reply.dart';
import 'package:truvideo_enterprise/model/checklist/reply/reply_extra_note/reply_extra_note.dart';
import 'package:truvideo_enterprise/model/checklist/reply/reply_form/reply_form.dart';
import 'package:truvideo_enterprise/model/checklist/section/section.dart';
import 'package:truvideo_enterprise/model/checklist/template/template.dart';
import 'package:truvideo_enterprise/model/user.dart';
import 'package:truvideo_enterprise/riverpod/auth.dart';
import 'package:truvideo_enterprise/service/checklist/_interface.dart';
import 'package:truvideo_enterprise/widget/common/animated_collapse_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/animated_switcher/index.dart';
import 'package:truvideo_enterprise/widget/common/app_bar/index.dart';
import 'package:truvideo_enterprise/widget/common/button_border/index.dart';
import 'package:truvideo_enterprise/widget/common/button_gradient/index.dart';
import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';
import 'package:truvideo_enterprise/widget/common/container/index.dart';
import 'package:truvideo_enterprise/widget/common/dialog/index.dart';
import 'package:truvideo_enterprise/widget/common/fading_edge_list/index.dart';
import 'package:truvideo_enterprise/widget/common/json_viewer/index.dart';
import 'package:truvideo_enterprise/widget/common/list/divider.dart';
import 'package:truvideo_enterprise/widget/common/list/indicator_error.dart';
import 'package:truvideo_enterprise/widget/common/list/list.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/image.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/index.dart';
import 'package:truvideo_enterprise/widget/common/scaffold/index.dart';
import 'package:truvideo_enterprise/widget/screen/checklist/buttons.dart';
import 'package:truvideo_enterprise/widget/screen/checklist/color_measure/index.dart';
import 'package:truvideo_enterprise/widget/screen/checklist/color_selector/index.dart';
import 'package:truvideo_enterprise/widget/screen/checklist/measure/index.dart';
import 'package:truvideo_enterprise/widget/screen/checklist/section_separator.dart';
import 'package:truvideo_enterprise/widget/screen/checklist/shimmer.dart';

import 'package:truvideo_enterprise/widget/screen/checklist/dialog.dart';

enum _ScreenMode {
  loading,
  template,
  checklist,
  error,
}

class ScreenChecklistParams {
  final String jobServiceNumber;
  CustomRouteType? routeType;

  ScreenChecklistParams({required this.jobServiceNumber, this.routeType});
}

class ScreenChecklist extends StatefulHookConsumerWidget {
  static const String routeName = "/ScreenChecklist";

  final ScreenChecklistParams params;

  const ScreenChecklist({
    Key? key,
    required this.params,
  }) : super(key: key);

  @override
  ConsumerState<ScreenChecklist> createState() => _ScreenChecklistState();
}

class _ScreenChecklistState extends ConsumerState<ScreenChecklist> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ReplyForm? _replyForm;
  Template? _template;
  var _templates = <Template>[];
  _ScreenMode _screenMode = _ScreenMode.loading;

  dynamic _error;
  bool _canPickTemplate = false;
  bool _buttonVisible = true;
  bool _saving = false;
  var _sectionVisible = <String, bool>{};

  ChecklistService get _checklistService => GetIt.I.get();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _init());
  }

  _init() async {
    if (widget.params.jobServiceNumber.trim().isEmpty) {
      Navigator.of(context).pop();
      return;
    }

    _fetchData();
  }

  int _getCreatedAt() => DateTime.now().millisecondsSinceEpoch ~/ Duration.millisecondsPerSecond;

  String _getUserName(UserModel? user) {
    // required for asigneeUID
    String result = '';
    try {
      final name = [(user?.firstName ?? ""), (user?.lastName ?? "")].where((e) => e != "").join(" ");
      result = name;
    } catch (e) {
      result = '';
    }
    return result;
  }

  _fetchData() async {
    try {
      setState(() {
        _screenMode = _ScreenMode.loading;
      });

      Template? template = _template;
      ReplyForm? replyForm;
      _ScreenMode screenMode;
      var templates = _templates;
      bool canPickTemplate = _canPickTemplate;

      final replies = await _checklistService.getTemplateReplyByEntity(widget.params.jobServiceNumber);

      if (replies.isEmpty) {
        log("No replies");

        if (template == null) {
          log("No template");
          canPickTemplate = true;
          templates = await _checklistService.getTemplates();
          template = null;
          replyForm = null;
          screenMode = _ScreenMode.template;
        } else {
          log("With template");
          template = await _checklistService.getTemplateByUID(template.uid);
          screenMode = _ScreenMode.checklist;
          final user = ref.read(authPod);
          replyForm = ReplyForm(
            createdAt: "${_getCreatedAt()}",
            updatedAt: "${_getCreatedAt()}",
            templateUID: _template?.uid ?? "",
            templateVersion: _template?.version ?? "",
            accountUID: _template?.accountUID ?? "",
            entityType: "REPAIR_ORDER",
            replyStatus: "",
            assigneeUID: _getUserName(user),
            entityUID: widget.params.jobServiceNumber,
            visibleFor: "CUSTOMER",
            replies: [],
          );
        }
      } else {
        log("With replies");
        screenMode = _ScreenMode.checklist;
        final currentReply = await _checklistService.getTemplateReplyByReplyID(replies.first.uid ?? "");
        replyForm = currentReply.reply;
        template = await _checklistService.getTemplateByUID(replyForm.templateUID);
      }

      if (!mounted) return;

      setState(() {
        _canPickTemplate = canPickTemplate;
        _templates = templates;
        _replyForm = replyForm;
        _template = template;
        _screenMode = screenMode;
      });
    } catch (error) {
      log("Error fetching", error: error);
      if (!mounted) return;

      setState(() {
        _screenMode = _ScreenMode.error;
        _error = error;
      });
    }
  }

  void _addReply(Reply reply) {
    final replyForm = _replyForm;
    if (replyForm == null) return;

    List<Reply> replies = replyForm.replies.toList();
    replies.add(reply);
    setState(() {
      _replyForm = replyForm.copyWith(replies: replies);
    });
  }

  void _updateReply(Reply reply) {
    final replyForm = _replyForm;
    if (replyForm == null) return;

    final replies = replyForm.replies.map((e) {
      if (e.itemUID == reply.itemUID) {
        return reply;
      }

      return e;
    }).toList();

    setState(() {
      _replyForm = replyForm.copyWith(replies: replies);
    });
  }

  void _removeReply(String itemUID) {
    final replyForm = _replyForm;
    if (replyForm == null) return;

    final replies = replyForm.replies.where((e) => e.itemUID != itemUID).toList();
    setState(() {
      _replyForm = replyForm.copyWith(replies: replies);
    });
  }

  void _saveReply(Item item, Reply? reply) {
    final replyForm = _replyForm;
    if (replyForm == null) return;

    if (reply == null) {
      _removeReply(item.uid);
    } else {
      final index = replyForm.replies.indexWhere((element) => element.itemUID == reply.itemUID);
      if (index == -1) {
        _addReply(reply);
      } else {
        _updateReply(reply);
      }
    }
  }

  Widget _buildItem(Item item, bool completed) {
    switch (item.inputType) {
      case "CHECKBOX":
      case "COLOR":
        return CheckListColorSelectorFormField(
          item: item,
          completed: completed,
          replies: _replies,
          initialValue: _replies.firstWhereOrNull((element) => element.itemUID == item.uid),
          onSaved: (reply) => _saveReply(item, reply),
          validator: (value) {
            final withValue = value != null;
            if (!withValue && !item.skippable) return "This field is required";
            return null;
          },
        );

      case "COLOR_MEASURE":
        return CheckListColorMeasureFormField(
          initialValue: _replies.firstWhereOrNull((element) => element.itemUID == item.uid),
          completed: completed,
          item: item,
          replies: _replies,
          onSaved: (reply) => _saveReply(item, reply),
          validator: (value) {
            final withValue = value != null;
            if (!withValue && !item.skippable) return "This field is required";

            if (withValue) {
              // selectedColorUID is the first row of options
              final selectedColorUID = value.optionGroupUID;
              final selectedOption = item.availableOptions.firstWhereOrNull((element) => element.uid == selectedColorUID);
              final selectedOptionOptions = selectedOption?.availableOptions ?? [];

              // if it has available options (every color but grey)
              // but OptionUID is empty then its not finished
              bool hasAvailableOptions = selectedOptionOptions.isNotEmpty;
              if (hasAvailableOptions && (value.optionUID?.trim() ?? "").isEmpty) {
                return "Additional measurment required";
              }
            }
            return null;
          },
        );
      case "MEASURE":
        return CheckListMeasureField(
          item: item,
          completed: completed,
          initialValue: _replies.firstWhereOrNull((e) => e.itemUID == item.uid),
          onSaved: (reply) => _saveReply(item, reply),
        );
    }

    return Container();
  }

  int get _sectionsLength => _sections.length;

  List<Section> get _sections => _template?.definitions?.sections ?? <Section>[];

  List<Reply> get _replies => _replyForm?.replies ?? <Reply>[];

  _markAllAsGreen() async {
    final replyForm = _replyForm;
    final template = _template;
    if (replyForm == null || template == null) return;

    setState(() {
      _replyForm = replyForm.copyWith(replies: template.markAllGreen(_replies));
    });

    await CustomWidgetUtils.wait();
    _formKey.currentState!.reset();
    _formKey.currentState!.validate();
  }

  _submit() async {
    final replyForm = _replyForm;
    final template = _template;
    if (replyForm == null || template == null) return;

    if (_isReadOnly) return;

    if (!_formKey.currentState!.validate()) {
      await showCustomDialog(message: "The form contains errors");
      return;
    }

    setState(() {
      _saving = true;
    });

    try {
      final ChecklistService checklistService = GetIt.I.get();
      final model = replyForm.copyWith(replyStatus: "SUBMITTED");

      String newReplyID = '';
      final id = await checklistService.saveTemplateReply(model.toJson());
      if (id != null) newReplyID = id;
      if (!mounted) return;
      Navigator.pop(context, newReplyID);
    } catch (error, stack) {
      log("Error submitting", error: error, stackTrace: stack);
      if (!mounted) return;

      final retry = await showErrorMessage();
      if (retry) {
        _submit();
      } else {
        setState(() {
          _saving = false;
        });
      }
    }
  }

  bool get _isReadOnly => _replyForm?.readOnly ?? true;

  bool get _isComplete => _template?.isTemplateCompleted(_replies) ?? false;

  Future<bool> _onWillPop() async {
    return _close(pop: false);
  }

  Future<bool> _close({
    bool pop = true,
  }) async {
    final replyForm = _replyForm;
    final template = _template;
    final loading = _screenMode == _ScreenMode.loading;
    if (loading || replyForm == null || template == null) {
      if (pop) {
        Navigator.of(context).pop();
      }
      return true;
    }

    if (_saving) return false;

    if (!replyForm.readOnly) {
      /// Only asks confirmation if reply form is new
      bool exitConfirmation = await showConfirmationExitDialog();
      if (!exitConfirmation) return false;
    }

    if (pop) {
      if (!mounted) return false;
      Navigator.of(context).pop();
    }
    return true;
  }

  Widget _buildTemplateList({required BuildContext context}) {
    return CustomFadingEdgeList(
      child: CustomList<Template>.separated(
        padding: const EdgeInsets.symmetric(vertical: 16).copyWith(
          bottom: 16 + MediaQuery.of(context).padding.bottom,
        ),
        data: _templates,
        areItemsTheSame: (a, b) => a.uid == b.uid,
        itemBuilder: (context, item) => CustomListTile(
          titleText: item.templateName,
          onPressed: () {
            setState(() {
              _template = item;
            });
            _fetchData();
          },
        ),
      ),
    );
  }

  _askChangeTemplate() async {
    final change = await showCustomDialog<bool>(
      title: "Are you sure?",
      buttonsBuilder: (context, controller) => [
        CustomBorderButton.small(
          text: "Cancel",
          onPressed: controller.close,
        ),
        CustomGradientButton.small(
          gradient: CustomColorsUtils.gradient,
          text: "Yes",
          onPressed: () => controller.close(result: true),
        ),
      ],
    );

    if (change != true) return;
    setState(() {
      _template = null;
      _canPickTemplate = true;
      _screenMode = _ScreenMode.template;
    });
  }

  Widget _buildList(BuildContext context, {required bool isComplete}) {
    final replyFormReadOnly = _replyForm?.readOnly ?? false;
    final readOnly = replyFormReadOnly || _saving;
    final mq = MediaQuery.of(context);
    return _bottomButtonsWrapper(
      isComplete: isComplete,
      child: Column(
        children: [
          Expanded(
            child: Form(
              key: _formKey,
              child: CustomFadingEdgeList(
                child: ListView.builder(
                  padding: EdgeInsets.only(
                    top: 16,
                    bottom: 16 + mq.viewPadding.bottom + (readOnly ? 0.0 : 150),
                  ),
                  controller: ModalScrollController.of(context),
                  itemBuilder: (context, index) {
                    if (_canPickTemplate && index == 0) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 32),
                        child: CustomListTile(
                          titleText: "Change template",
                          color: Theme.of(context).dividerColor,
                          dense: true,
                          leading: const CustomListTileImage(icon: Icons.arrow_back, color: Colors.transparent),
                          onPressed: _askChangeTemplate,
                        ),
                      );
                    }

                    index = _canPickTemplate ? (index - 1) : index;

                    final section = _sections[index];
                    final isLastSection = index == (_sectionsLength - 1);
                    final sectionVisible = _sectionVisible[section.uid] ?? false;

                    // Items
                    final itemsLength = section.items.length;
                    final items = <Widget>[];
                    for (int itemIndex = 0; itemIndex < itemsLength; itemIndex++) {
                      final isLastItem = itemIndex == (section.items.length - 1);
                      final widget = Column(
                        children: [
                          _buildItem(section.items[itemIndex], readOnly),
                          if (!isLastItem) const CustomDivider(margin: EdgeInsets.symmetric(vertical: 16)),
                        ],
                      );
                      items.add(widget);
                    }

                    return Container(
                      margin: EdgeInsets.only(bottom: isLastSection ? 0.0 : 16.0),
                      child: Column(
                        children: [
                          ChecklistSectionSeparator(
                            expanded: sectionVisible,
                            section: section,
                            replies: _replies,
                            onPressed: (s) {
                              setState(() {
                                _sectionVisible = Map<String, bool>.from(_sectionVisible)..[s.uid] = !sectionVisible;
                              });
                            },
                          ),
                          CustomAnimatedCollapseVisibility(
                            visible: sectionVisible,
                            child: Container(
                              margin: const EdgeInsets.only(top: 16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: items,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: _sectionsLength + (_canPickTemplate ? 1 : 0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomButtonsWrapper({
    required Widget child,
    required bool isComplete,
  }) {
    final replyFormReadOnly = _replyForm?.readOnly ?? false;
    if (replyFormReadOnly) return child;

    final buttonsVisible = _buttonVisible || isComplete;

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        bool visible = _buttonVisible;

        if (notification is UserScrollNotification) {
          switch (notification.direction) {
            case ScrollDirection.idle:
              break;
            case ScrollDirection.forward:
              visible = true;
              break;
            case ScrollDirection.reverse:
              visible = false;
              break;
          }
        }

        if (notification.metrics.pixels >= notification.metrics.maxScrollExtent) {
          visible = true;
        }

        if (visible != _buttonVisible) {
          setState(() {
            _buttonVisible = visible;
          });
        }

        return false;
      },
      child: Stack(
        children: [
          Positioned.fill(child: child),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CheckListButtons(
              visible: buttonsVisible,
              onButtonMarkAsGreenPressed: _markAllAsGreen,
              onButtonSubmitPressed: _submit,
              submitEnabled: isComplete,
              submitLoading: _saving,
              markAsGreenEnabled: !_saving,
            ),
          )
        ],
      ),
    );
  }

  bool get _isAnyExpanded {
    return _sectionVisible.entries.any((e) => e.value == true);
  }

  _onInfoPressed() {
    if (_replies.isEmpty) return;

    showCustomDialog(
      title: "Replies",
      childPadding: EdgeInsets.zero,
      builder: (context, controller) => CustomList<Reply>.separated(
        data: _replies,
        itemBuilder: (context, item) => CustomJsonViewer(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          json: item.toJson(),
        ),
        shrinkWrap: true,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        areItemsTheSame: (a, b) => a.itemUID == b.itemUID,
      ),
      buttonsBuilder: (context, controller) => [
        CustomBorderButton.small(
          text: "Accept",
          onPressed: controller.close,
        ),
      ],
    );
  }

  CustomContainerMode get _containerMode {
    switch (_screenMode) {
      case _ScreenMode.loading:
        return CustomContainerMode.loading;
      case _ScreenMode.template:
        return CustomContainerMode.normal;
      case _ScreenMode.checklist:
        return CustomContainerMode.normal;
      case _ScreenMode.error:
        return CustomContainerMode.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isRouteTypeCupertinoVertical = widget.params.routeType == CustomRouteType.cupertinoVertical;
    Color appBarFillColor;
    Color appBarIconColor;
    if (isRouteTypeCupertinoVertical) {
      appBarFillColor = Theme.of(context).scaffoldBackgroundColor;
    } else {
      appBarFillColor = Theme.of(context).colorScheme.secondary;
    }
    appBarIconColor = appBarFillColor.contrast(context);

    final buttonClose = CustomButtonIcon(
      icon: isRouteTypeCupertinoVertical ? Icons.clear : Icons.arrow_back_ios,
      iconColor: appBarIconColor,
      backgroundColor: Colors.transparent,
      onPressed: _close,
    );

    final isComplete = useMemoized(() => _isComplete, [_template, _replies]);
    final isAnyExpanded = useMemoized(() => _isAnyExpanded, [_sectionVisible]);
    final isDebug = useIsDebug(ref);

    final replyFormReadOnly = _replyForm?.readOnly ?? false;
    final loading = _screenMode == _ScreenMode.loading;
    final error = _screenMode == _ScreenMode.error;

    return CustomScaffold(
      onWillPop: (loading || replyFormReadOnly || error || _template == null) ? null : _onWillPop,
      resizeToAvoidBottomInset: false,
      appbar: CustomAppBar(
        backgroundColor: appBarFillColor,
        title: "Inspection",
        titleColor: appBarIconColor,
        leading: isRouteTypeCupertinoVertical ? null : buttonClose,
        actionButtons: [
          CustomAnimatedFadeVisibility(
            visible: _screenMode == _ScreenMode.checklist,
            child: CustomAnimatedSwitcher(
              alignment: Alignment.centerRight,
              child: CustomBorderButton.small(
                key: ValueKey(isAnyExpanded),
                textColor: appBarIconColor,
                text: isAnyExpanded ? "Collapse all" : "Expand all",
                onPressed: () {
                  final map = <String, bool>{};
                  if (!_isAnyExpanded) {
                    for (var element in _sections) {
                      map[element.uid] = true;
                    }
                  }

                  setState(() {
                    _sectionVisible = map;
                  });
                },
              ),
            ),
          ),
          if (isDebug)
            CustomButtonIcon(
              icon: Icons.info_outline,
              backgroundColor: Colors.transparent,
              iconColor: appBarIconColor,
              onPressed: _onInfoPressed,
            ),
          if (isRouteTypeCupertinoVertical) buttonClose
        ],
      ),
      body: CustomContainer(
        mode: _containerMode,
        errorData: _error,
        loadingBuilder: (context) => const CheckListShimmer(),
        errorBuilder: (context, errorData) => CustomListIndicatorError(error: error, onButtonPressed: _fetchData),
        builder: (context) => CustomAnimatedSwitcher(
          child: _template == null
              ? _buildTemplateList(context: context)
              : _buildList(
                  context,
                  isComplete: isComplete,
                ),
        ),
      ),
    );
  }
}

Reply? saveExtraNote({
  required Reply? reply,
  required ExtraNote extraNote,
  required ReplyExtraNote? replyExtraNote,
}) {
  if (reply == null) return null;

  // existing extra Notes
  var newReplyNotes = List<ReplyExtraNote>.from(reply.replyExtraNote?.toList() ?? []);

  // getting index from the new Extra Note to see if exists
  if (replyExtraNote == null) {
    newReplyNotes = newReplyNotes.where((e) => e.optionUID != extraNote.uid).toList();
  } else {
    final index = newReplyNotes.indexWhere((e) => e.optionUID == replyExtraNote.optionUID);
    if (index == -1) {
      newReplyNotes.add(replyExtraNote);
    } else {
      newReplyNotes[index] = replyExtraNote;
    }
  }

  return reply.copyWith(replyExtraNote: newReplyNotes);
}
