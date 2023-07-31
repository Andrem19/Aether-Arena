import '../controllers/main_game_controller.dart';
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

static String typeOfActionToString(TypeOfAction action) {
  switch (action) {
    case TypeOfAction.Heal:
      return 'Heal';
    case TypeOfAction.Attack:
      return 'Attack';
    case TypeOfAction.Defence:
      return 'Defence';
    case TypeOfAction.Poison:
      return 'Poison';
    case TypeOfAction.Weaken:
      return 'Weaken';
    case TypeOfAction.Break:
      return 'Break';
    case TypeOfAction.Strength:
      return 'Strength';
    case TypeOfAction.Dexterity:
      return 'Dexterity';
    case TypeOfAction.Intelligence:
      return 'Intelligence';
    case TypeOfAction.None:
    default:
      return 'None';
  }
}

static TypeOfAction typeOfActionFromString(String actionString) {
  switch (actionString) {
    case 'Heal':
      return TypeOfAction.Heal;
    case 'Attack':
      return TypeOfAction.Attack;
    case 'Defence':
      return TypeOfAction.Defence;
    case 'Poison':
      return TypeOfAction.Poison;
    case 'Weaken':
      return TypeOfAction.Weaken;
    case 'Break':
      return TypeOfAction.Break;
    case 'Strength':
      return TypeOfAction.Strength;
    case 'Dexterity':
      return TypeOfAction.Dexterity;
    case 'Intelligence':
      return TypeOfAction.Intelligence;
    case 'None':
    default:
      return TypeOfAction.None;
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
        return Target.None;
        ;
    }
  }

  static String GameTypetoString(GameType type) {
    switch (type) {
      case GameType.LadderBattle:
        return 'LadderBattle';
      case GameType.QuickBattle:
        return 'QuickBattle';
      case GameType.PrivateBattle:
        return 'PrivateBattle';
    }
  }

  static GameType GameTypefromString(String value) {
    switch (value) {
      case 'LadderBattle':
        return GameType.LadderBattle;
      case 'QuickBattle':
        return GameType.QuickBattle;
      case 'PrivateBattle':
        return GameType.PrivateBattle;
      default:
        throw ArgumentError('Invalid GameType value: $value');
    }
  }
}
