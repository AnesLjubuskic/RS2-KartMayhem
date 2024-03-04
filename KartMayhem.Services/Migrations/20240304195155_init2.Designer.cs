﻿// <auto-generated />
using System;
using KartMayhem.Services.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

#nullable disable

namespace KartMayhem.Services.Migrations
{
    [DbContext(typeof(KartMayhemContext))]
    [Migration("20240304195155_init2")]
    partial class init2
    {
        /// <inheritdoc />
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "8.0.2")
                .HasAnnotation("Relational:MaxIdentifierLength", 128);

            SqlServerModelBuilderExtensions.UseIdentityColumns(modelBuilder);

            modelBuilder.Entity("KartMayhem.Services.Database.Korisnici", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Email")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Ime")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<bool?>("IsActive")
                        .HasColumnType("bit");

                    b.Property<string>("LozinkaHash")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("LozinkaSalt")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int?>("NagradaId")
                        .HasColumnType("int");

                    b.Property<string>("Prezime")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.HasIndex("NagradaId");

                    b.ToTable("Korisnicis");
                });

            modelBuilder.Entity("KartMayhem.Services.Database.KorisniciUloge", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<int>("KorisnikId")
                        .HasColumnType("int");

                    b.Property<int>("UlogaId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("KorisnikId");

                    b.HasIndex("UlogaId");

                    b.ToTable("KorisniciUloges");
                });

            modelBuilder.Entity("KartMayhem.Services.Database.Nagrade", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("NazivNagrade")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("Nagrades");
                });

            modelBuilder.Entity("KartMayhem.Services.Database.Opreme", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("OpisOpreme")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("Opremes");
                });

            modelBuilder.Entity("KartMayhem.Services.Database.Rezencije", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Komentar")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("StazaId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("StazaId");

                    b.ToTable("Rezencijes");
                });

            modelBuilder.Entity("KartMayhem.Services.Database.Rezervacije", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<int>("BrojOsoba")
                        .HasColumnType("int");

                    b.Property<int>("CijenaRezervacije")
                        .HasColumnType("int");

                    b.Property<DateTime>("DayOfReservation")
                        .HasColumnType("datetime2");

                    b.Property<int>("KorisnikId")
                        .HasColumnType("int");

                    b.Property<int>("StazaId")
                        .HasColumnType("int");

                    b.Property<DateTime>("TimeSlot")
                        .HasColumnType("datetime2");

                    b.HasKey("Id");

                    b.HasIndex("KorisnikId");

                    b.HasIndex("StazaId");

                    b.ToTable("Rezervacijes");
                });

            modelBuilder.Entity("KartMayhem.Services.Database.RezervacijeOpreme", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<int>("OpremaId")
                        .HasColumnType("int");

                    b.Property<int>("RezervacijaId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("OpremaId");

                    b.HasIndex("RezervacijaId");

                    b.ToTable("RezervacijeOpremes");
                });

            modelBuilder.Entity("KartMayhem.Services.Database.StatistikeStaze", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<int>("BrojRezervacija")
                        .HasColumnType("int");

                    b.Property<int>("StazaId")
                        .HasColumnType("int");

                    b.Property<int>("UkupnaZarada")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("StazaId");

                    b.ToTable("StatistikeStaze");
                });

            modelBuilder.Entity("KartMayhem.Services.Database.Staze", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<int>("BrojKrugova")
                        .HasColumnType("int");

                    b.Property<int>("CijenaPoOsobi")
                        .HasColumnType("int");

                    b.Property<double>("DuzinaStaze")
                        .HasColumnType("float");

                    b.Property<int>("MaxBrojOsoba")
                        .HasColumnType("int");

                    b.Property<string>("NazivStaze")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("OpisStaze")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("TezinaId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("TezinaId");

                    b.ToTable("Stazes");
                });

            modelBuilder.Entity("KartMayhem.Services.Database.Tezine", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Naziv")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("Tezines");
                });

            modelBuilder.Entity("KartMayhem.Services.Database.Uloge", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Naziv")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("Uloges");
                });

            modelBuilder.Entity("KartMayhem.Services.Database.Korisnici", b =>
                {
                    b.HasOne("KartMayhem.Services.Database.Nagrade", "Nagrada")
                        .WithMany("Korisnicis")
                        .HasForeignKey("NagradaId");

                    b.Navigation("Nagrada");
                });

            modelBuilder.Entity("KartMayhem.Services.Database.KorisniciUloge", b =>
                {
                    b.HasOne("KartMayhem.Services.Database.Korisnici", "Korisnik")
                        .WithMany("KorisniciUloges")
                        .HasForeignKey("KorisnikId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("KartMayhem.Services.Database.Uloge", "Uloga")
                        .WithMany("KorisniciUloges")
                        .HasForeignKey("UlogaId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Korisnik");

                    b.Navigation("Uloga");
                });

            modelBuilder.Entity("KartMayhem.Services.Database.Rezencije", b =>
                {
                    b.HasOne("KartMayhem.Services.Database.Staze", "Staza")
                        .WithMany("Rezencijes")
                        .HasForeignKey("StazaId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Staza");
                });

            modelBuilder.Entity("KartMayhem.Services.Database.Rezervacije", b =>
                {
                    b.HasOne("KartMayhem.Services.Database.Korisnici", "Korisnik")
                        .WithMany()
                        .HasForeignKey("KorisnikId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("KartMayhem.Services.Database.Staze", "Staza")
                        .WithMany("Rezervacijes")
                        .HasForeignKey("StazaId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Korisnik");

                    b.Navigation("Staza");
                });

            modelBuilder.Entity("KartMayhem.Services.Database.RezervacijeOpreme", b =>
                {
                    b.HasOne("KartMayhem.Services.Database.Opreme", "Oprema")
                        .WithMany("RezervacijeOpremes")
                        .HasForeignKey("OpremaId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("KartMayhem.Services.Database.Rezervacije", "Rezervacija")
                        .WithMany("RezervacijeOpremes")
                        .HasForeignKey("RezervacijaId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Oprema");

                    b.Navigation("Rezervacija");
                });

            modelBuilder.Entity("KartMayhem.Services.Database.StatistikeStaze", b =>
                {
                    b.HasOne("KartMayhem.Services.Database.Staze", "Staza")
                        .WithMany()
                        .HasForeignKey("StazaId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Staza");
                });

            modelBuilder.Entity("KartMayhem.Services.Database.Staze", b =>
                {
                    b.HasOne("KartMayhem.Services.Database.Tezine", "Tezina")
                        .WithMany("Staze")
                        .HasForeignKey("TezinaId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Tezina");
                });

            modelBuilder.Entity("KartMayhem.Services.Database.Korisnici", b =>
                {
                    b.Navigation("KorisniciUloges");
                });

            modelBuilder.Entity("KartMayhem.Services.Database.Nagrade", b =>
                {
                    b.Navigation("Korisnicis");
                });

            modelBuilder.Entity("KartMayhem.Services.Database.Opreme", b =>
                {
                    b.Navigation("RezervacijeOpremes");
                });

            modelBuilder.Entity("KartMayhem.Services.Database.Rezervacije", b =>
                {
                    b.Navigation("RezervacijeOpremes");
                });

            modelBuilder.Entity("KartMayhem.Services.Database.Staze", b =>
                {
                    b.Navigation("Rezencijes");

                    b.Navigation("Rezervacijes");
                });

            modelBuilder.Entity("KartMayhem.Services.Database.Tezine", b =>
                {
                    b.Navigation("Staze");
                });

            modelBuilder.Entity("KartMayhem.Services.Database.Uloge", b =>
                {
                    b.Navigation("KorisniciUloges");
                });
#pragma warning restore 612, 618
        }
    }
}
