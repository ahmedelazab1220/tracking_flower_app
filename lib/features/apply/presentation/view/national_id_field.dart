import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/assets/app_colors.dart';
import '../../../../core/base/base_state.dart';
import '../../../../core/utils/dialogs/app_dialogs.dart';
import '../../../../core/utils/l10n/locale_keys.g.dart';
import '../view_model/cubit/apply_cubit.dart';

class NationalIdField extends StatefulWidget {
  const NationalIdField({super.key});

  @override
  State<NationalIdField> createState() => _NationalIdFieldState();
}

class _NationalIdFieldState extends State<NationalIdField> {
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  Future<void> _handleImageSelection(ImageSource source) async {
    setState(() => _isLoading = true);

    final viewModel = context.read<ApplyCubit>();

    try {
      final image = await _picker.pickImage(
        source: source,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 85,
      );

      if (image != null && mounted) {
        setState(() => viewModel.nationalIdImage = File(image.path));
        viewModel.doIntent(ExtractDataFromNationalIdAction());
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: AppColors.pink),
              title: Text(LocaleKeys.TakeAPhoto.tr()),
              onTap: () {
                Navigator.pop(context);
                _handleImageSelection(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: AppColors.green),
              title: Text(LocaleKeys.ChooseFromGallery.tr()),
              onTap: () {
                Navigator.pop(context);
                _handleImageSelection(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ApplyCubit>();
    return BlocListener<ApplyCubit, ApplyState>(
      listenWhen:
          (prev, curr) =>
              prev.extractDataFromNationalIdState !=
              curr.extractDataFromNationalIdState,
      listener: (context, state) {
        if (state.extractDataFromNationalIdState is BaseErrorState) {
          final rawError =
              (state.extractDataFromNationalIdState as BaseErrorState)
                  .errorMessage;
          final userMessage = rawError.replaceFirst('Exception:', '').trim();
          AppDialogs.showFailureDialog(
            context,
            message: LocaleKeys.InvalidNationalID.tr(),
            description: userMessage,
          );
        }
      },
      child: InkWell(
        onTap: () => _showImageSourceDialog(),
        child: AbsorbPointer(
          absorbing: true,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: LocaleKeys.IDImage.tr(),
              hintText:
                  viewModel.nationalIdImage == null
                      ? LocaleKeys.UploadIDImage.tr()
                      : '',
              prefixIcon:
                  viewModel.nationalIdImage == null
                      ? null
                      : Container(
                        width: 160,
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: FileImage(viewModel.nationalIdImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
              suffixIcon: const Icon(Icons.file_upload_outlined),
            ),
          ),
        ),
      ),
    );
  }
}
