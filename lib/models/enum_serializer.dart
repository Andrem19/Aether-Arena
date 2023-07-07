import 'enums.dart';

class EnumSerializer {
  static Energy energyFromString(String energyString) {
    switch (energyString) {
      case 'PHYSICAL':
        return Energy.PHYSICAL;
      case 'ARCANE':
        return Energy.ARCANE;
      case 'UNIQUE':
        return Energy.UNIQUE;
      case 'WILLPOWER':
        return Energy.WILLPOWER;
      case 'RANDOM':
        return Energy.RANDOM;
      default:
        return Energy.NONE;
    }
  }

  static String energyToString(Energy energy) {
    switch (energy) {
      case Energy.PHYSICAL:
        return 'PHYSICAL';
      case Energy.ARCANE:
        return 'ARCANE';
      case Energy.UNIQUE:
        return 'UNIQUE';
      case Energy.WILLPOWER:
        return 'WILLPOWER';
      case Energy.RANDOM:
        return 'RANDOM';
      default:
        return 'NONE';
    }
  }

 static PersistenceType persistenceTypeFromString(String value) {
    switch (value) {
      case 'Instant':
        return PersistenceType.Instant;
      case 'Action':
        return PersistenceType.Action;
      case 'Control':
        return PersistenceType.Control;
      case 'None':
        return PersistenceType.None;
      default:
        return PersistenceType.None;
    }
  }

  static String persistenceTypeToString(PersistenceType type) {
    switch (type) {
      case PersistenceType.Instant:
        return 'Instant';
      case PersistenceType.Action:
        return 'Action';
      case PersistenceType.Control:
        return 'Control';
      case PersistenceType.None:
        return 'None';
      default:
        return 'None';
    }
  }

  static String distanceToString(Distance distance) {
    switch (distance) {
      case Distance.Melee:
        return 'Melee';
      case Distance.Ranged:
        return 'Ranged';
      case Distance.None:
        return 'None';
      default:
        return 'None';
    }
  }

  static Distance distanceFromString(String distanceString) {
    switch (distanceString.toLowerCase()) {
      case 'melee':
        return Distance.Melee;
      case 'ranged':
        return Distance.Ranged;
      case 'none':
        return Distance.None;
      default:
        return Distance.None;
    }
  }

  static TypeOfAction typeOfActionFromString(String typeOfActionString) {
    switch (typeOfActionString) {
      case 'Heal':
        return TypeOfAction.Heal;
      case 'NormalDamage':
        return TypeOfAction.NormalDamage;
      case 'PureDamage':
        return TypeOfAction.PureDamage;
      case 'DamageReduction':
        return TypeOfAction.DamageReduction;
      case 'DestructibleArmour':
        return TypeOfAction.DestructibleArmour;
      case 'UnpierceableArmour':
        return TypeOfAction.UnpierceableArmour;
      case 'FullInvulnerability':
        return TypeOfAction.FullInvulnerability;
      case 'MeleeInvulnerability':
        return TypeOfAction.MeleeInvulnerability;
      case 'RangedInvulnerability':
        return TypeOfAction.RangedInvulnerability;
      case 'PhysicalSkillsInvulnerability':
        return TypeOfAction.PhysicalSkillsInvulnerability;
      case 'ArcaneSkillsInvulnerability':
        return TypeOfAction.ArcaneSkillsInvulnerability;
      case 'MentalSkillsInvulnerability':
        return TypeOfAction.MentalSkillsInvulnerability;
      case 'PureSkillsInvulnerability':
        return TypeOfAction.PureSkillsInvulnerability;
      case 'Stun':
        return TypeOfAction.Stun;
      case 'RemoveEnergy':
        return TypeOfAction.RemoveEnergy;
      case 'StealEnergy':
        return TypeOfAction.StealEnergy;
      case 'Reflect':
        return TypeOfAction.Reflect;
      case 'Counter':
        return TypeOfAction.Counter;
      case 'PurgeAll':
        return TypeOfAction.PurgeAll;
      case 'PurgeEnemyEffects':
        return TypeOfAction.PurgeEnemyEffects;
      case 'PurgeGoodEffects':
        return TypeOfAction.PurgeGoodEffects;
      case 'Copy':
        return TypeOfAction.Copy;
      case 'Invisible':
        return TypeOfAction.Invisible;
      case 'CannotReduceDamageOrBecomeInvulnerable':
        return TypeOfAction.CannotReduceDamageOrBecomeInvulnerable;
      default:
        return TypeOfAction.None;
    }
  }

  static String typeOfActionToString(TypeOfAction typeOfAction) {
    switch (typeOfAction) {
      case TypeOfAction.Heal:
        return 'Heal';
      case TypeOfAction.NormalDamage:
        return 'NormalDamage';
      case TypeOfAction.PureDamage:
        return 'PureDamage';
      case TypeOfAction.DamageReduction:
        return 'DamageReduction';
      case TypeOfAction.DestructibleArmour:
        return 'DestructibleArmour';
      case TypeOfAction.UnpierceableArmour:
        return 'UnpierceableArmour';
      case TypeOfAction.FullInvulnerability:
        return 'FullInvulnerability';
      case TypeOfAction.MeleeInvulnerability:
        return 'MeleeInvulnerability';
      case TypeOfAction.RangedInvulnerability:
        return 'RangedInvulnerability';
      case TypeOfAction.PhysicalSkillsInvulnerability:
        return 'PhysicalSkillsInvulnerability';
      case TypeOfAction.ArcaneSkillsInvulnerability:
        return 'ArcaneSkillsInvulnerability';
      case TypeOfAction.MentalSkillsInvulnerability:
        return 'MentalSkillsInvulnerability';
      case TypeOfAction.PureSkillsInvulnerability:
        return 'PureSkillsInvulnerability';
      case TypeOfAction.Stun:
        return 'Stun';
      case TypeOfAction.RemoveEnergy:
        return 'RemoveEnergy';
      case TypeOfAction.StealEnergy:
        return 'StealEnergy';
      case TypeOfAction.Reflect:
        return 'Reflect';
      case TypeOfAction.Counter:
        return 'Counter';
      case TypeOfAction.PurgeAll:
        return 'PurgeAll';
      case TypeOfAction.PurgeEnemyEffects:
        return 'PurgeEnemyEffects';
      case TypeOfAction.PurgeGoodEffects:
        return 'PurgeGoodEffects';
      case TypeOfAction.Copy:
        return 'Copy';
      case TypeOfAction.Invisible:
        return 'Invisible';
      case TypeOfAction.CannotReduceDamageOrBecomeInvulnerable:
        return 'CannotReduceDamageOrBecomeInvulnerable';
      case TypeOfAction.None:
        return 'None';
    }
  }

  static String energyEffectToString(EnergyEffect effect) {
    switch (effect) {
      case EnergyEffect.Remove:
        return 'Remove';
      case EnergyEffect.Steel:
        return 'Steel';
      case EnergyEffect.Add:
        return 'Add';
      case EnergyEffect.None:
        return 'None';
    }
  }

  static EnergyEffect energyEffectFromString(String effect) {
    switch (effect) {
      case 'Remove':
        return EnergyEffect.Remove;
      case 'Steel':
        return EnergyEffect.Steel;
      case 'Add':
        return EnergyEffect.Add;
      case 'None':
        return EnergyEffect.None;
      case '':
        return EnergyEffect.None;
      default:
        return EnergyEffect.None;
    }
  }

  static String targetToString(Target target) {
    switch (target) {
      case Target.Myself:
        return 'Myself';
      case Target.AllAliveAnemy:
        return 'AllAliveAnemy';
      case Target.SingleEnemyTarget:
        return 'SingleEnemyTarget';
      case Target.AllAliveAlly:
        return 'AllAliveAlly';
      case Target.SingleAlly:
        return 'SingleAlly';
      case Target.AllAliveInGame:
        return 'AllAliveInGame';
      case Target.RandomAllTarget:
        return 'RandomAllTarget';
      case Target.RandomEnemyTarget:
        return 'RandomEnemyTarget';
      case Target.None:
        return 'None';
    }
  }

  static Target targetFromString(String str) {
    switch (str) {
      case 'Myself':
        return Target.Myself;
      case 'AllAliveAnemy':
        return Target.AllAliveAnemy;
      case 'SingleEnemyTarget':
        return Target.SingleEnemyTarget;
      case 'AllAliveAlly':
        return Target.AllAliveAlly;
      case 'SingleAlly':
        return Target.SingleAlly;
      case 'AllAliveInGame':
        return Target.AllAliveInGame;
      case 'RandomAllTarget':
        return Target.RandomAllTarget;
      case 'RandomEnemyTarget':
        return Target.RandomEnemyTarget;
      case 'None':
        return Target.None;
      case '':
        return Target.None;
      default:
        return Target.None;;
    }
  }

  static SkillType skillTypeFromString(String value) {
    switch (value.toLowerCase()) {
      case 'physical':
        return SkillType.Physical;
      case 'arcane':
        return SkillType.Arcane;
      case 'mental':
        return SkillType.Mental;
      case 'pure':
        return SkillType.Pure;
      default:
        return SkillType.None;
    }
  }

  static String skillTypeToString(SkillType skillType) {
    switch (skillType) {
      case SkillType.Physical:
        return 'Physical';
      case SkillType.Arcane:
        return 'Arcane';
      case SkillType.Mental:
        return 'Mental';
      case SkillType.Pure:
        return 'Pure';
      default:
        return 'None';
    }
  }
}