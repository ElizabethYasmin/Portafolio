/// Interface para verificar conectividad
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

/// Implementación de NetworkInfo
/// En producción, usar internet_connection_checker
class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async {
    // Por ahora retornamos true
    // En producción: usar internet_connection_checker
    return true;
  }
}
