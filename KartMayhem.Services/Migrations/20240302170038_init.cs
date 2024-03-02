using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace KartMayhem.Services.Migrations
{
    /// <inheritdoc />
    public partial class init : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Nagrades",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    NazivNagrade = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Nagrades", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Opremes",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    OpisOpreme = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Opremes", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Tezines",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Tezines", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Uloges",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Uloges", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Korisnicis",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Ime = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Prezime = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Email = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    KorisnickoIme = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    LozinkaHash = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    LozinkaSalt = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    IsActive = table.Column<bool>(type: "bit", nullable: true),
                    NagradaId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Korisnicis", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Korisnicis_Nagrades_NagradaId",
                        column: x => x.NagradaId,
                        principalTable: "Nagrades",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Stazes",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    NazivStaze = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    OpisStaze = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CijenaPoOsobi = table.Column<int>(type: "int", nullable: false),
                    DuzinaStaze = table.Column<double>(type: "float", nullable: false),
                    BrojKrugova = table.Column<int>(type: "int", nullable: false),
                    MaxBrojOsoba = table.Column<int>(type: "int", nullable: false),
                    TezinaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Stazes", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Stazes_Tezines_TezinaId",
                        column: x => x.TezinaId,
                        principalTable: "Tezines",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "KorisniciUloges",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    UlogaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_KorisniciUloges", x => x.Id);
                    table.ForeignKey(
                        name: "FK_KorisniciUloges_Korisnicis_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnicis",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_KorisniciUloges_Uloges_UlogaId",
                        column: x => x.UlogaId,
                        principalTable: "Uloges",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Rezencijes",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Komentar = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    StazaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Rezencijes", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Rezencijes_Stazes_StazaId",
                        column: x => x.StazaId,
                        principalTable: "Stazes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Rezervacijes",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    CijenaRezervacije = table.Column<int>(type: "int", nullable: false),
                    BrojOsoba = table.Column<int>(type: "int", nullable: false),
                    DayOfReservation = table.Column<DateTime>(type: "datetime2", nullable: false),
                    TimeSlot = table.Column<DateTime>(type: "datetime2", nullable: false),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    StazaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Rezervacijes", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Rezervacijes_Korisnicis_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnicis",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Rezervacijes_Stazes_StazaId",
                        column: x => x.StazaId,
                        principalTable: "Stazes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "StatistikeStaze",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    BrojRezervacija = table.Column<int>(type: "int", nullable: false),
                    UkupnaZarada = table.Column<int>(type: "int", nullable: false),
                    StazaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_StatistikeStaze", x => x.Id);
                    table.ForeignKey(
                        name: "FK_StatistikeStaze_Stazes_StazaId",
                        column: x => x.StazaId,
                        principalTable: "Stazes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "RezervacijeOpremes",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    RezervacijaId = table.Column<int>(type: "int", nullable: false),
                    OpremaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_RezervacijeOpremes", x => x.Id);
                    table.ForeignKey(
                        name: "FK_RezervacijeOpremes_Opremes_OpremaId",
                        column: x => x.OpremaId,
                        principalTable: "Opremes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_RezervacijeOpremes_Rezervacijes_RezervacijaId",
                        column: x => x.RezervacijaId,
                        principalTable: "Rezervacijes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_KorisniciUloges_KorisnikId",
                table: "KorisniciUloges",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_KorisniciUloges_UlogaId",
                table: "KorisniciUloges",
                column: "UlogaId");

            migrationBuilder.CreateIndex(
                name: "IX_Korisnicis_NagradaId",
                table: "Korisnicis",
                column: "NagradaId");

            migrationBuilder.CreateIndex(
                name: "IX_Rezencijes_StazaId",
                table: "Rezencijes",
                column: "StazaId");

            migrationBuilder.CreateIndex(
                name: "IX_RezervacijeOpremes_OpremaId",
                table: "RezervacijeOpremes",
                column: "OpremaId");

            migrationBuilder.CreateIndex(
                name: "IX_RezervacijeOpremes_RezervacijaId",
                table: "RezervacijeOpremes",
                column: "RezervacijaId");

            migrationBuilder.CreateIndex(
                name: "IX_Rezervacijes_KorisnikId",
                table: "Rezervacijes",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_Rezervacijes_StazaId",
                table: "Rezervacijes",
                column: "StazaId");

            migrationBuilder.CreateIndex(
                name: "IX_StatistikeStaze_StazaId",
                table: "StatistikeStaze",
                column: "StazaId");

            migrationBuilder.CreateIndex(
                name: "IX_Stazes_TezinaId",
                table: "Stazes",
                column: "TezinaId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "KorisniciUloges");

            migrationBuilder.DropTable(
                name: "Rezencijes");

            migrationBuilder.DropTable(
                name: "RezervacijeOpremes");

            migrationBuilder.DropTable(
                name: "StatistikeStaze");

            migrationBuilder.DropTable(
                name: "Uloges");

            migrationBuilder.DropTable(
                name: "Opremes");

            migrationBuilder.DropTable(
                name: "Rezervacijes");

            migrationBuilder.DropTable(
                name: "Korisnicis");

            migrationBuilder.DropTable(
                name: "Stazes");

            migrationBuilder.DropTable(
                name: "Nagrades");

            migrationBuilder.DropTable(
                name: "Tezines");
        }
    }
}
