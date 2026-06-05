-- -------------------------------------------------------------
-- SQL Database Seeding Script for Tennis Club Application
-- Database Engine: PostgreSQL 15+
-- -------------------------------------------------------------

-- Start transaction
BEGIN;

-- Clean existing data (Optional but highly recommended for clean slate)
TRUNCATE TABLE "reservation_players" RESTART IDENTITY CASCADE;
TRUNCATE TABLE "reservation" RESTART IDENTITY CASCADE;
TRUNCATE TABLE "contribution" RESTART IDENTITY CASCADE;
TRUNCATE TABLE "members_groups" RESTART IDENTITY CASCADE;
TRUNCATE TABLE "courts" RESTART IDENTITY CASCADE;
TRUNCATE TABLE "auth_group" RESTART IDENTITY CASCADE;
TRUNCATE TABLE "categories" RESTART IDENTITY CASCADE;

-- 1. Seed Groups in auth_group
-- ID 1 is for admin role, ID 2 is for member role
INSERT INTO "auth_group" ("id", "name") VALUES
(1, 'admin'),
(2, 'member');

-- Seed Categories
INSERT INTO "categories" ("id", "name", "min_age", "max_age", "gender") VALUES
(1, 'JF/JG -9ans', NULL, 9, NULL),
(2, 'JF-11 ans', 10, 11, 'female'),
(3, 'JG-11 ans', 10, 11, 'male'),
(4, 'JF-13 ans', 12, 13, 'female'),
(5, 'JG-13 ans', 12, 13, 'male'),
(6, 'JF-15 ans', 14, 15, 'female'),
(7, 'JG-15 ans', 14, 15, 'male'),
(8, 'JF-17 ans', 16, 17, 'female'),
(9, 'JG-17 ans', 16, 17, 'male'),
(10, 'Dames 25', 25, NULL, 'female'),
(11, 'Dames 35', 35, NULL, 'female'),
(12, 'Messieurs 35', 35, NULL, 'male'),
(13, 'Dames 45', 45, NULL, 'female'),
(14, 'Dames 55', 55, NULL, 'female'),
(15, 'Messieurs 55', 55, NULL, 'male'),
(16, 'Messieurs 60', 60, NULL, 'male'),
(17, 'Messieurs 65', 65, NULL, 'male'),
(18, 'Messieurs 70', 70, NULL, 'male'),
(19, 'Dames', 16, NULL, 'female'),
(20, 'Messieurs', 16, NULL, 'male');


-- 2. Seed Members
-- Passwords are set to (SELECT password FROM "members" WHERE affiliation_number = 'admin') (plain text: 'password')
INSERT INTO "members" (
    "id", "password", "last_login", "is_superuser", "first_name", "last_name",
    "is_staff", "is_active", "is_first_login", "date_joined", "email", "affiliation_number",
    "street", "city", "postal_code", "country", "phone", "birth_date",
    "gender", "google_subject_id", "ranking", "created_at"
) VALUES
(
    2,
    (SELECT password FROM "members" WHERE affiliation_number = 'admin'),
    NULL,
    FALSE,
    'Jean',
    'Dupont',
    FALSE,
    TRUE,
    TRUE,
    NOW() - INTERVAL '25 days',
    'jean.dupont@gmail.com',
    '1000001',
    '12 Rue de la Paix',
    'Paris',
    '75002',
    'France',
    '+33612345678',
    '1988-06-15',
    'male',
    NULL,
    'C15.2',
    NOW() - INTERVAL '25 days'
),
(
    3,
    (SELECT password FROM "members" WHERE affiliation_number = 'admin'),
    NULL,
    FALSE,
    'Marie',
    'Dubois',
    FALSE,
    TRUE,
    TRUE,
    NOW() - INTERVAL '20 days',
    'marie.dubois@gmail.com',
    '1000002',
    '45 Avenue des Champs-Élysées',
    'Paris',
    '75008',
    'France',
    '+33687654321',
    '1992-04-20',
    'female',
    NULL,
    'B-4/6',
    NOW() - INTERVAL '20 days'
),
(
    4,
    (SELECT password FROM "members" WHERE affiliation_number = 'admin'),
    NULL,
    FALSE,
    'Pierre',
    'Martin',
    FALSE,
    TRUE,
    TRUE,
    NOW() - INTERVAL '15 days',
    'pierre.martin@gmail.com',
    '1000003',
    '8 Rue du Faubourg Saint-Antoine',
    'Paris',
    '75012',
    'France',
    '+33611223344',
    '1985-11-02',
    'male',
    NULL,
    'C30',
    NOW() - INTERVAL '15 days'
),
(
    5,
    (SELECT password FROM "members" WHERE affiliation_number = 'admin'),
    NULL,
    FALSE,
    'Sophie',
    'Lefevre',
    FALSE,
    TRUE,
    TRUE,
    NOW() - INTERVAL '10 days',
    'sophie.lefevre@gmail.com',
    '1000004',
    '22 Rue de Rivoli',
    'Paris',
    '75004',
    'France',
    '+33655667788',
    '1995-09-30',
    'female',
    NULL,
    'C15.4',
    NOW() - INTERVAL '10 days'
),
(
    6,
    (SELECT password FROM "members" WHERE affiliation_number = 'admin'),
    NULL,
    FALSE,
    'Thomas',
    'Bernard',
    FALSE,
    FALSE, -- Inactive member
    TRUE,
    NOW() - INTERVAL '5 days',
    'thomas.bernard@gmail.com',
    '1000005',
    '14 Boulevard Saint-Germain',
    'Paris',
    '75005',
    'France',
    '+33699887766',
    '1990-01-25',
    'male',
    NULL,
    'C30.1',
    NOW() - INTERVAL '5 days'
),
(
    7,
    (SELECT password FROM "members" WHERE affiliation_number = 'admin'),
    NULL,
    FALSE,
    'Lucas',
    'Legrand',
    FALSE,
    TRUE,
    TRUE,
    NOW() - INTERVAL '4 days',
    'lucas.legrand@gmail.com',
    '1000006',
    '50 Rue de Rennes',
    'Paris',
    '75006',
    'France',
    '+33622334455',
    '1991-03-12',
    'male',
    NULL,
    'C15.1',
    NOW() - INTERVAL '4 days'
),
(
    8,
    (SELECT password FROM "members" WHERE affiliation_number = 'admin'),
    NULL,
    FALSE,
    'Emma',
    'Petit',
    FALSE,
    TRUE,
    TRUE,
    NOW() - INTERVAL '4 days',
    'emma.petit@gmail.com',
    '1000007',
    '3 Boulevard Haussmann',
    'Paris',
    '75009',
    'France',
    '+33633445566',
    '1994-07-22',
    'female',
    NULL,
    'C30.2',
    NOW() - INTERVAL '4 days'
),
(
    9,
    (SELECT password FROM "members" WHERE affiliation_number = 'admin'),
    NULL,
    FALSE,
    'Hugo',
    'Roux',
    FALSE,
    TRUE,
    TRUE,
    NOW() - INTERVAL '3 days',
    'hugo.roux@gmail.com',
    '1000008',
    '18 Avenue d''Italie',
    'Paris',
    '75013',
    'France',
    '+33644556677',
    '1989-10-05',
    'male',
    NULL,
    'C15.4',
    NOW() - INTERVAL '3 days'
),
(
    10,
    (SELECT password FROM "members" WHERE affiliation_number = 'admin'),
    NULL,
    FALSE,
    'Chloe',
    'Barbier',
    FALSE,
    TRUE,
    TRUE,
    NOW() - INTERVAL '3 days',
    'chloe.barbier@gmail.com',
    '1000009',
    '72 Avenue de la Grande Armée',
    'Paris',
    '75017',
    'France',
    '+33655667788',
    '1993-12-14',
    'female',
    NULL,
    'NC',
    NOW() - INTERVAL '3 days'
),
(
    11,
    (SELECT password FROM "members" WHERE affiliation_number = 'admin'),
    NULL,
    FALSE,
    'Nathan',
    'Morel',
    FALSE,
    TRUE,
    TRUE,
    NOW() - INTERVAL '2 days',
    'nathan.morel@gmail.com',
    '1000010',
    '95 Rue Lafayette',
    'Paris',
    '75010',
    'France',
    '+33666778899',
    '1996-02-28',
    'male',
    NULL,
    'C30.3',
    NOW() - INTERVAL '2 days'
),
(
    12,
    (SELECT password FROM "members" WHERE affiliation_number = 'admin'),
    NULL,
    FALSE,
    'Zoe',
    'Gerard',
    FALSE,
    TRUE,
    TRUE,
    NOW() - INTERVAL '2 days',
    'zoe.gerard@gmail.com',
    '1000011',
    '142 Avenue Daumesnil',
    'Paris',
    '75012',
    'France',
    '+33677889900',
    '1997-08-19',
    'female',
    NULL,
    'C15.3',
    NOW() - INTERVAL '2 days'
),
(
    13,
    (SELECT password FROM "members" WHERE affiliation_number = 'admin'),
    NULL,
    FALSE,
    'Enzo',
    'Guerin',
    FALSE,
    TRUE,
    TRUE,
    NOW() - INTERVAL '1 day',
    'enzo.guerin@gmail.com',
    '1000012',
    '88 Rue de Belleville',
    'Paris',
    '75020',
    'France',
    '+33688990011',
    '1990-05-30',
    'male',
    NULL,
    'C30.4',
    NOW() - INTERVAL '1 day'
),
(
    14,
    (SELECT password FROM "members" WHERE affiliation_number = 'admin'),
    NULL,
    FALSE,
    'Leia',
    'Muller',
    FALSE,
    TRUE,
    TRUE,
    NOW() - INTERVAL '1 day',
    'leia.muller@gmail.com',
    '1000013',
    '31 Rue de la Clef',
    'Paris',
    '75005',
    'France',
    '+33699001122',
    '1995-11-11',
    'female',
    NULL,
    'C30',
    NOW() - INTERVAL '1 day'
),
(
    15,
    (SELECT password FROM "members" WHERE affiliation_number = 'admin'),
    NULL,
    FALSE,
    'Leo',
    'Lemoine',
    FALSE,
    TRUE,
    TRUE,
    NOW() - INTERVAL '12 hours',
    'leo.lemoine@gmail.com',
    '1000014',
    '64 Rue Saint-Charles',
    'Paris',
    '75015',
    'France',
    '+33600112233',
    '1992-09-08',
    'male',
    NULL,
    'C15.4',
    NOW() - INTERVAL '12 hours'
),
(
    16,
    (SELECT password FROM "members" WHERE affiliation_number = 'admin'),
    NULL,
    FALSE,
    'Lina',
    'Rousseau',
    FALSE,
    TRUE,
    TRUE,
    NOW() - INTERVAL '6 hours',
    'lina.rousseau@gmail.com',
    '1000015',
    '112 Avenue de Flandre',
    'Paris',
    '75019',
    'France',
    '+33611223344',
    '1998-04-03',
    'female',
    NULL,
    'C30.1',
    NOW() - INTERVAL '6 hours'
),
(
    17,
    (SELECT password FROM "members" WHERE affiliation_number = 'admin'),
    NULL,
    FALSE,
    'Alice',
    'Mercier',
    FALSE,
    TRUE,
    TRUE,
    NOW() - INTERVAL '1 day',
    'alice.mercier@gmail.com',
    '1000016',
    '12 Rue des Lilas',
    'Lyon',
    '69001',
    'France',
    '+33622114455',
    '2015-05-10',
    'female',
    NULL,
    'NC',
    NOW() - INTERVAL '1 day'
),
(
    18,
    (SELECT password FROM "members" WHERE affiliation_number = 'admin'),
    NULL,
    FALSE,
    'Louis',
    'Dupuis',
    FALSE,
    TRUE,
    TRUE,
    NOW() - INTERVAL '1 day',
    'louis.dupuis@gmail.com',
    '1000017',
    '5 Place Bellecour',
    'Lyon',
    '69002',
    'France',
    '+33699881122',
    '2013-08-12',
    'male',
    NULL,
    'C30.4',
    NOW() - INTERVAL '1 day'
),
(
    19,
    (SELECT password FROM "members" WHERE affiliation_number = 'admin'),
    NULL,
    FALSE,
    'Catherine',
    'Deneuve',
    FALSE,
    TRUE,
    TRUE,
    NOW() - INTERVAL '1 day',
    'catherine.deneuve@gmail.com',
    '1000018',
    '88 Avenue Foch',
    'Paris',
    '75116',
    'France',
    '+33677553311',
    '1979-02-14',
    'female',
    NULL,
    'C15.1',
    NOW() - INTERVAL '1 day'
),
(
    20,
    (SELECT password FROM "members" WHERE affiliation_number = 'admin'),
    NULL,
    FALSE,
    'Jean-Pierre',
    'Marielle',
    FALSE,
    TRUE,
    TRUE,
    NOW() - INTERVAL '1 day',
    'jp.marielle@gmail.com',
    '1000019',
    '3 Avenue Montaigne',
    'Paris',
    '75008',
    'France',
    '+33688442200',
    '1959-12-01',
    'male',
    NULL,
    'C30.2',
    NOW() - INTERVAL '1 day'
);

-- 3. Seed Group Mappings (members_groups)
INSERT INTO "members_groups" ("member_id", "group_id") VALUES
(1, 1), -- Admin in Admin group
(2, 2),
(3, 2),
(4, 2),
(5, 2),
(6, 2),
(7, 2), 
(8, 2),
(9, 2),
(10, 2),
(11, 2),
(12, 2),
(13, 2),
(14, 2),
(15, 2),
(16, 2),
(17, 2),
(18, 2),
(19, 2),
(20, 2);

-- 4. Seed Courts
INSERT INTO "courts" ("id", "name", "is_active") VALUES
(1, 'Court Central', TRUE),
(2, 'Court N°2', TRUE),
(3, 'Court N°3', TRUE),
(4, 'Court N°4 (Indoor)', TRUE),
(5, 'Court N°5 (Clay)', TRUE),
(6, 'Court N°6 (Maintenance)', FALSE);

-- 5. Seed Contributions
-- Completed contributions for paid active members (Jean, Marie, Pierre)
-- One pending contribution for Sophie, and none for Thomas (inactive)
INSERT INTO "contribution" ("id", "amount", "stripe_session_id", "status", "created_at", "updated_at", "member_id") VALUES
(1, 200.00, 'cs_test_a1b2c3d4e5_01', 'completed', NOW() - INTERVAL '20 days', NOW() - INTERVAL '20 days', 2),
(2, 200.00, 'cs_test_a1b2c3d4e5_02', 'completed', NOW() - INTERVAL '15 days', NOW() - INTERVAL '15 days', 3),
(3, 200.00, 'cs_test_a1b2c3d4e5_03', 'completed', NOW() - INTERVAL '10 days', NOW() - INTERVAL '10 days', 4),
(4, 200.00, 'cs_test_a1b2c3d4e5_04', 'pending',   NOW() - INTERVAL '2 days',  NOW() - INTERVAL '2 days',  5),
(5, 200.00, 'cs_test_a1b2c3d4e5_05', 'completed', NOW() - INTERVAL '4 days',  NOW() - INTERVAL '4 days',  7),
(6, 200.00, 'cs_test_a1b2c3d4e5_06', 'completed', NOW() - INTERVAL '4 days',  NOW() - INTERVAL '4 days',  8),
(7, 200.00, 'cs_test_a1b2c3d4e5_07', 'completed', NOW() - INTERVAL '3 days',  NOW() - INTERVAL '3 days',  9),
(8, 200.00, 'cs_test_a1b2c3d4e5_08', 'completed', NOW() - INTERVAL '3 days',  NOW() - INTERVAL '3 days',  10),
(9, 200.00, 'cs_test_a1b2c3d4e5_09', 'completed', NOW() - INTERVAL '2 days',  NOW() - INTERVAL '2 days',  11),
(10, 200.00, 'cs_test_a1b2c3d4e5_10', 'completed', NOW() - INTERVAL '2 days',  NOW() - INTERVAL '2 days',  12),
(11, 200.00, 'cs_test_a1b2c3d4e5_11', 'completed', NOW() - INTERVAL '1 day',   NOW() - INTERVAL '1 day',   13),
(12, 200.00, 'cs_test_a1b2c3d4e5_12', 'completed', NOW() - INTERVAL '1 day',   NOW() - INTERVAL '1 day',   14),
(13, 200.00, 'cs_test_a1b2c3d4e5_13', 'completed', NOW() - INTERVAL '12 hours', NOW() - INTERVAL '12 hours', 15),
(14, 200.00, 'cs_test_a1b2c3d4e5_14', 'completed', NOW() - INTERVAL '6 hours',  NOW() - INTERVAL '6 hours',  16),
(15, 200.00, 'cs_test_a1b2c3d4e5_15', 'completed', NOW() - INTERVAL '1 day',   NOW() - INTERVAL '1 day',   17),
(16, 200.00, 'cs_test_a1b2c3d4e5_16', 'completed', NOW() - INTERVAL '1 day',   NOW() - INTERVAL '1 day',   18),
(17, 200.00, 'cs_test_a1b2c3d4e5_17', 'completed', NOW() - INTERVAL '1 day',   NOW() - INTERVAL '1 day',   19),
(18, 200.00, 'cs_test_a1b2c3d4e5_18', 'completed', NOW() - INTERVAL '1 day',   NOW() - INTERVAL '1 day',   20);

-- 6. Seed Reservations
-- Reservation 1: Simple reservation between Jean and Marie (on Court Central today)
-- We'll use absolute timestamps for today (or dynamically generated today/tomorrow)
INSERT INTO "reservation" ("id", "date_time", "duration", "court_id", "creator_id", "type") VALUES
(1, CURRENT_DATE + TIME '09:00:00', 60, 1, 2, 'simple'),
(2, CURRENT_DATE + TIME '14:00:00', 120, 2, 3, 'double'),
(3, CURRENT_DATE + TIME '10:00:00', 180, 3, 1, 'blocage_admin'),
(4, (CURRENT_DATE + INTERVAL '1 day') + TIME '16:00:00', 60, 4, 2, 'simple');

-- 7. Seed Reservation Players (Many-to-Many mapping)
-- For Simple reservation: Both creator and partner are players
-- For Double reservation: All four players are registered
-- For Admin Blockage: Just the admin creator is registered
INSERT INTO "reservation_players" ("reservation_id", "member_id") VALUES
(1, 2), -- Jean
(1, 3), -- Marie

(2, 2), -- Jean
(2, 3), -- Marie
(2, 4), -- Pierre
(2, 5), -- Sophie

(3, 1), -- Admin

(4, 2), -- Jean
(4, 4); -- Pierre

-- 8. Reset Auto-Increment Sequences
-- This prevents unique constraint violations when Django creates new records
SELECT setval(pg_get_serial_sequence('auth_group', 'id'), COALESCE((SELECT max(id) FROM auth_group), 1));
SELECT setval(pg_get_serial_sequence('members', 'id'), COALESCE((SELECT max(id) FROM members), 1));
SELECT setval(pg_get_serial_sequence('members_groups', 'id'), COALESCE((SELECT max(id) FROM members_groups), 1));
SELECT setval(pg_get_serial_sequence('courts', 'id'), COALESCE((SELECT max(id) FROM courts), 1));
SELECT setval(pg_get_serial_sequence('contribution', 'id'), COALESCE((SELECT max(id) FROM contribution), 1));
SELECT setval(pg_get_serial_sequence('reservation', 'id'), COALESCE((SELECT max(id) FROM reservation), 1));
SELECT setval(pg_get_serial_sequence('reservation_players', 'id'), COALESCE((SELECT max(id) FROM reservation_players), 1));
SELECT setval(pg_get_serial_sequence('categories', 'id'), COALESCE((SELECT max(id) FROM categories), 1));

-- End transaction
COMMIT;
