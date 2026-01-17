import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

/// endpoint for delivery channel crud operations
class DeliveryChannelEndpoint extends Endpoint {
  /// create a new delivery channel
  Future<DeliveryChannel> create(
    Session session,
    DeliveryChannel channel,
  ) async {
    channel.createdAt = DateTime.now();
    channel.updatedAt = DateTime.now();
    return await DeliveryChannel.db.insertRow(session, channel);
  }

  /// get delivery channels by company id
  Future<List<DeliveryChannel>> listByCompany(
    Session session,
    int companyId,
  ) async {
    return await DeliveryChannel.db.find(
      session,
      where: (t) => t.companyId.equals(companyId),
      orderBy: (t) => t.name,
    );
  }

  /// get active delivery channels by company id
  Future<List<DeliveryChannel>> listActiveByCompany(
    Session session,
    int companyId,
  ) async {
    return await DeliveryChannel.db.find(
      session,
      where: (t) => t.companyId.equals(companyId) & t.isActive.equals(true),
      orderBy: (t) => t.name,
    );
  }

  /// get default channel for company
  Future<DeliveryChannel?> getDefault(Session session, int companyId) async {
    final channels = await DeliveryChannel.db.find(
      session,
      where: (t) => t.companyId.equals(companyId) & t.isDefault.equals(true),
      limit: 1,
    );
    return channels.isNotEmpty ? channels.first : null;
  }

  /// get channel by id
  Future<DeliveryChannel?> getById(Session session, int id) async {
    return await DeliveryChannel.db.findById(session, id);
  }

  /// update delivery channel
  Future<DeliveryChannel> update(
    Session session,
    DeliveryChannel channel,
  ) async {
    channel.updatedAt = DateTime.now();
    return await DeliveryChannel.db.updateRow(session, channel);
  }

  /// set as default channel for company
  Future<DeliveryChannel> setDefault(Session session, int id) async {
    final channel = await DeliveryChannel.db.findById(session, id);
    if (channel == null) throw Exception('Channel not found');

    // unset current default
    final currentDefaults = await DeliveryChannel.db.find(
      session,
      where: (t) =>
          t.companyId.equals(channel.companyId) & t.isDefault.equals(true),
    );
    for (final c in currentDefaults) {
      c.isDefault = false;
      c.updatedAt = DateTime.now();
      await DeliveryChannel.db.updateRow(session, c);
    }

    // set new default
    channel.isDefault = true;
    channel.updatedAt = DateTime.now();
    return await DeliveryChannel.db.updateRow(session, channel);
  }

  /// toggle channel active status
  Future<DeliveryChannel> toggleActive(Session session, int id) async {
    final channel = await DeliveryChannel.db.findById(session, id);
    if (channel == null) throw Exception('Channel not found');

    channel.isActive = !channel.isActive;
    channel.updatedAt = DateTime.now();
    return await DeliveryChannel.db.updateRow(session, channel);
  }

  /// delete channel by id
  Future<bool> delete(Session session, int id) async {
    final deleted = await DeliveryChannel.db.deleteWhere(
      session,
      where: (t) => t.id.equals(id),
    );
    return deleted.isNotEmpty;
  }
}
