import 'dart:ffi';
import 'dart:io';
import 'package:onnxruntime/src/bindings/onnxruntime_bindings_generated.dart';

final DynamicLibrary _dylib = () {
  if (Platform.isAndroid) {
    return DynamicLibrary.open('libonnxruntime.so');
  }

  if (Platform.isIOS) {
    return DynamicLibrary.process();
  }

  if (Platform.isMacOS) {
    return DynamicLibrary.open('libonnxruntime.1.15.1.dylib');
  }

  if (Platform.isWindows) {
    return DynamicLibrary.open('onnxruntime.dll');
  }

  if (Platform.isLinux) {
    return DynamicLibrary.open('libonnxruntime.so.1.20.2');
  }

  throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
}();

/// OnnxRuntime Bindings
final onnxRuntimeBinding = OnnxRuntimeBindings(_dylib);

String onnxRuntimeExtensionsLibName = () {
  if (Platform.isAndroid || Platform.isLinux) {
    return "libortextensions.so";
  }

  if (Platform.isMacOS) {
    return "libortextensions.dylib";
  }

  if (Platform.isWindows) {
    return "libortextensions.dll";
  }

  if (Platform.isIOS) {
    return "onnxruntime_extensions.framework/onnxruntime_extensions";
  }

  throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
}();
